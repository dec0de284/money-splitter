import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_splitter/data/app_database.dart';
import 'package:money_splitter/data/profile_repository.dart';

void main() {
  late AppDatabase database;
  late ProfileRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = ProfileRepository(database);
  });

  tearDown(() => database.close());

  test('creates and loads a complete ordered profile', () async {
    final result = await repository.saveProfile(
      name: 'Monthly plan',
      capitalName: 'Monthly income',
      capitalMinorUnits: 700000,
      splitters: const [
        SplitterDraftData(name: 'Savings', percentage: 50),
        SplitterDraftData(name: 'Expenses', percentage: 30),
      ],
    );
    final profileId = result.profileId;

    final aggregate = await repository.loadProfile(profileId);
    expect(aggregate?.profile.name, 'Monthly plan');
    expect(aggregate?.profile.capitalMinorUnits, 700000);
    expect(aggregate?.splitters.map((row) => row.name), [
      'Savings',
      'Expenses',
    ]);
  });

  test('updates the same profile when its name is unchanged', () async {
    final created = await repository.saveProfile(
      name: 'Original',
      capitalName: 'Income',
      capitalMinorUnits: 100000,
      splitters: const [SplitterDraftData(name: 'Old', percentage: 60)],
    );
    final profileId = created.profileId;

    final updated = await repository.saveProfile(
      profileId: profileId,
      name: 'Original',
      capitalName: 'Pay',
      capitalMinorUnits: 200000,
      splitters: const [SplitterDraftData(name: 'New', percentage: 40)],
    );

    final aggregate = await repository.loadProfile(profileId);
    expect(updated.profileId, profileId);
    expect(updated.wasCreated, isFalse);
    expect(aggregate?.profile.name, 'Original');
    expect(aggregate?.splitters.single.name, 'New');
  });

  test('rejects invalid totals without inserting a profile', () async {
    await expectLater(
      repository.saveProfile(
        name: 'Invalid',
        capitalName: 'Income',
        capitalMinorUnits: 100000,
        splitters: const [
          SplitterDraftData(name: 'One', percentage: 60),
          SplitterDraftData(name: 'Two', percentage: 41),
        ],
      ),
      throwsArgumentError,
    );

    expect(await database.select(database.profiles).get(), isEmpty);
  });

  test('deleting a profile cascades to its splitters', () async {
    final result = await repository.saveProfile(
      name: 'Delete me',
      capitalName: 'Income',
      capitalMinorUnits: 100000,
      splitters: const [SplitterDraftData(name: 'Savings', percentage: 25)],
    );
    final profileId = result.profileId;

    await repository.deleteProfile(profileId);

    expect(await repository.loadProfile(profileId), isNull);
    expect(await database.select(database.splitters).get(), isEmpty);
    expect(await database.select(database.profileThemes).get(), isEmpty);
  });

  test(
    'loads favorite first, otherwise the profile with the highest id',
    () async {
      final first = await repository.saveProfile(
        name: 'First',
        capitalName: 'Income',
        capitalMinorUnits: 100000,
        splitters: const [],
      );
      final second = await repository.saveProfile(
        name: 'Second',
        capitalName: 'Income',
        capitalMinorUnits: 200000,
        splitters: const [],
      );

      expect(
        (await repository.loadStartupProfile())?.aggregate.profile.id,
        second.profileId,
      );
      await repository.setFavorite(first.profileId, true);
      expect(
        (await repository.loadStartupProfile())?.aggregate.profile.id,
        first.profileId,
      );
    },
  );

  test('stores one theme preference per profile', () async {
    final result = await repository.saveProfile(
      name: 'Theme test',
      capitalName: 'Income',
      capitalMinorUnits: 100000,
      splitters: const [],
    );
    final profileId = result.profileId;

    expect((await repository.loadTheme(profileId)).isAuto, isTrue);
    await repository.setTheme(profileId, isAuto: false, isDark: true);
    final preference = await repository.loadTheme(profileId);
    expect(preference.isAuto, isFalse);
    expect(preference.isDark, isTrue);
    expect(await database.select(database.profileThemes).get(), hasLength(1));
  });

  test(
    'changed profile name creates a new profile when name is unused',
    () async {
      final original = await repository.saveProfile(
        name: 'Original',
        capitalName: 'Income',
        capitalMinorUnits: 100000,
        splitters: const [],
      );

      final renamed = await repository.saveProfile(
        profileId: original.profileId,
        name: 'New profile',
        capitalName: 'Income',
        capitalMinorUnits: 100000,
        splitters: const [],
      );

      expect(renamed.wasCreated, isTrue);
      expect(renamed.profileId, isNot(original.profileId));
      expect(await database.select(database.profiles).get(), hasLength(2));
    },
  );
}
