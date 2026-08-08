import 'package:drift/drift.dart';

import 'app_database.dart';

class SplitterDraftData {
  const SplitterDraftData({required this.name, required this.percentage});

  final String name;
  final int percentage;
}

class ProfileAggregate {
  const ProfileAggregate({required this.profile, required this.splitters});

  final Profile profile;
  final List<Splitter> splitters;
}

class ProfileThemePreference {
  const ProfileThemePreference({required this.isAuto, required this.isDark});

  final bool isAuto;
  final bool isDark;
}

class StartupProfileData {
  const StartupProfileData({required this.aggregate, required this.theme});

  final ProfileAggregate aggregate;
  final ProfileThemePreference theme;
}

class ProfileSaveResult {
  const ProfileSaveResult({required this.profileId, required this.wasCreated});

  final int profileId;
  final bool wasCreated;
}

class ProfileRepository {
  const ProfileRepository(this._database);

  final AppDatabase _database;

  Stream<List<Profile>> watchProfiles() {
    return (_database.select(
      _database.profiles,
    )..orderBy([(profile) => OrderingTerm.desc(profile.updatedAt)])).watch();
  }

  Future<StartupProfileData?> loadStartupProfile() async {
    final profile =
        await (_database.select(_database.profiles)
              ..orderBy([
                (row) => OrderingTerm.desc(row.isFavorite),
                (row) => OrderingTerm.desc(row.id),
              ])
              ..limit(1))
            .getSingleOrNull();
    if (profile == null) return null;

    final results = await Future.wait([
      (_database.select(_database.splitters)
            ..where((row) => row.profileId.equals(profile.id))
            ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
          .get(),
      loadTheme(profile.id),
    ]);
    return StartupProfileData(
      aggregate: ProfileAggregate(
        profile: profile,
        splitters: results[0] as List<Splitter>,
      ),
      theme: results[1] as ProfileThemePreference,
    );
  }

  Future<ProfileThemePreference> loadTheme(int profileId) async {
    final row = await (_database.select(
      _database.profileThemes,
    )..where((theme) => theme.profileId.equals(profileId))).getSingleOrNull();
    return ProfileThemePreference(
      isAuto: row?.isAuto ?? true,
      isDark: row?.isDark ?? false,
    );
  }

  Future<void> setTheme(
    int profileId, {
    required bool isAuto,
    required bool isDark,
  }) async {
    final preference = ProfileThemesCompanion(
      isAuto: Value(isAuto),
      isDark: Value(isDark),
    );
    final updated = await (_database.update(
      _database.profileThemes,
    )..where((theme) => theme.profileId.equals(profileId))).write(preference);
    if (updated == 0) {
      await _database
          .into(_database.profileThemes)
          .insert(
            ProfileThemesCompanion.insert(
              profileId: profileId,
              isAuto: Value(isAuto),
              isDark: Value(isDark),
            ),
          );
    }
  }

  Future<void> setFavorite(int profileId, bool isFavorite) async {
    await _database.transaction(() async {
      if (isFavorite) {
        await _database
            .update(_database.profiles)
            .write(const ProfilesCompanion(isFavorite: Value(false)));
      }
      final updated =
          await (_database.update(_database.profiles)
                ..where((row) => row.id.equals(profileId)))
              .write(ProfilesCompanion(isFavorite: Value(isFavorite)));
      if (updated != 1) throw StateError('Profile $profileId does not exist.');
    });
  }

  Future<ProfileAggregate?> loadProfile(int profileId) async {
    final profile = await (_database.select(
      _database.profiles,
    )..where((row) => row.id.equals(profileId))).getSingleOrNull();
    if (profile == null) return null;

    final splitters =
        await (_database.select(_database.splitters)
              ..where((row) => row.profileId.equals(profileId))
              ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
            .get();
    return ProfileAggregate(profile: profile, splitters: splitters);
  }

  Future<ProfileSaveResult> saveProfile({
    int? profileId,
    required String name,
    required String capitalName,
    required int capitalMinorUnits,
    required List<SplitterDraftData> splitters,
  }) async {
    final cleanName = name.trim();
    final cleanCapitalName = capitalName.trim();
    final totalPercentage = splitters.fold<int>(
      0,
      (sum, splitter) => sum + splitter.percentage,
    );

    if (cleanName.isEmpty || cleanCapitalName.isEmpty) {
      throw ArgumentError('Profile and capital names are required.');
    }
    if (capitalMinorUnits <= 0) {
      throw ArgumentError.value(
        capitalMinorUnits,
        'capitalMinorUnits',
        'Must be greater than zero.',
      );
    }
    if (splitters.any(
      (splitter) =>
          splitter.name.trim().isEmpty ||
          splitter.percentage < 1 ||
          splitter.percentage > 100,
    )) {
      throw ArgumentError('Every splitter needs a name and 1-100 percentage.');
    }
    if (totalPercentage > 100) {
      throw ArgumentError('Total percentage must not exceed 100.');
    }

    return _database.transaction(() async {
      final now = DateTime.now();
      late final int savedProfileId;
      var wasCreated = false;
      var targetProfileId = profileId;

      if (targetProfileId != null) {
        final currentProfileId = targetProfileId;
        final current = await (_database.select(
          _database.profiles,
        )..where((row) => row.id.equals(currentProfileId))).getSingleOrNull();
        if (current == null) {
          throw StateError('Profile $currentProfileId does not exist.');
        }
        if (current.name.toLowerCase() != cleanName.toLowerCase()) {
          final existingWithName =
              await (_database.select(_database.profiles)
                    ..where(
                      (row) => row.name.lower().equals(cleanName.toLowerCase()),
                    )
                    ..limit(1))
                  .getSingleOrNull();
          targetProfileId = existingWithName?.id;
        }
      }

      if (targetProfileId == null) {
        wasCreated = true;
        savedProfileId = await _database
            .into(_database.profiles)
            .insert(
              ProfilesCompanion.insert(
                name: cleanName,
                capitalName: cleanCapitalName,
                capitalMinorUnits: capitalMinorUnits,
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      } else {
        final existingProfileId = targetProfileId;
        final updated =
            await (_database.update(
              _database.profiles,
            )..where((row) => row.id.equals(existingProfileId))).write(
              ProfilesCompanion(
                name: Value(cleanName),
                capitalName: Value(cleanCapitalName),
                capitalMinorUnits: Value(capitalMinorUnits),
                updatedAt: Value(now),
              ),
            );
        if (updated != 1) {
          throw StateError('Profile $existingProfileId does not exist.');
        }
        savedProfileId = existingProfileId;
        await (_database.delete(
          _database.splitters,
        )..where((row) => row.profileId.equals(existingProfileId))).go();
      }

      for (final (index, splitter) in splitters.indexed) {
        await _database
            .into(_database.splitters)
            .insert(
              SplittersCompanion.insert(
                profileId: savedProfileId,
                percentage: splitter.percentage,
                name: splitter.name.trim(),
                sortOrder: index,
              ),
            );
      }

      await _database
          .into(_database.profileThemes)
          .insert(
            ProfileThemesCompanion.insert(profileId: savedProfileId),
            mode: InsertMode.insertOrIgnore,
          );

      return ProfileSaveResult(
        profileId: savedProfileId,
        wasCreated: wasCreated,
      );
    });
  }

  Future<void> deleteProfile(int profileId) async {
    await (_database.delete(
      _database.profiles,
    )..where((row) => row.id.equals(profileId))).go();
  }
}
