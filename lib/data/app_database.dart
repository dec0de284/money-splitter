import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get capitalName => text().withLength(min: 1, max: 80)();
  IntColumn get capitalMinorUnits =>
      integer().customConstraint('NOT NULL CHECK (capital_minor_units > 0)')();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(name: 'splitters_profile_order', columns: {#profileId, #sortOrder})
class Splitters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId =>
      integer().references(Profiles, #id, onDelete: KeyAction.cascade)();
  IntColumn get percentage => integer().customConstraint(
    'NOT NULL CHECK (percentage BETWEEN 1 AND 100)',
  )();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  IntColumn get sortOrder =>
      integer().customConstraint('NOT NULL CHECK (sort_order >= 0)')();
}

class ProfileThemes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId => integer().unique().references(
    Profiles,
    #id,
    onDelete: KeyAction.cascade,
  )();
  BoolColumn get isAuto => boolean().withDefault(const Constant(true))();
  BoolColumn get isDark => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Profiles, Splitters, ProfileThemes])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'money_splitter',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(profiles, profiles.isFavorite);
        await migrator.createTable(profileThemes);
        await customStatement(
          'INSERT INTO profile_themes (profile_id, is_auto, is_dark) '
          'SELECT id, 1, 0 FROM profiles',
        );
      }
    },
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
