// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capitalNameMeta = const VerificationMeta(
    'capitalName',
  );
  @override
  late final GeneratedColumn<String> capitalName = GeneratedColumn<String>(
    'capital_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capitalMinorUnitsMeta = const VerificationMeta(
    'capitalMinorUnits',
  );
  @override
  late final GeneratedColumn<int> capitalMinorUnits = GeneratedColumn<int>(
    'capital_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (capital_minor_units > 0)',
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    capitalName,
    capitalMinorUnits,
    isFavorite,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('capital_name')) {
      context.handle(
        _capitalNameMeta,
        capitalName.isAcceptableOrUnknown(
          data['capital_name']!,
          _capitalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_capitalNameMeta);
    }
    if (data.containsKey('capital_minor_units')) {
      context.handle(
        _capitalMinorUnitsMeta,
        capitalMinorUnits.isAcceptableOrUnknown(
          data['capital_minor_units']!,
          _capitalMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_capitalMinorUnitsMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      capitalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capital_name'],
      )!,
      capitalMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capital_minor_units'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final String name;
  final String capitalName;
  final int capitalMinorUnits;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Profile({
    required this.id,
    required this.name,
    required this.capitalName,
    required this.capitalMinorUnits,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['capital_name'] = Variable<String>(capitalName);
    map['capital_minor_units'] = Variable<int>(capitalMinorUnits);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      name: Value(name),
      capitalName: Value(capitalName),
      capitalMinorUnits: Value(capitalMinorUnits),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      capitalName: serializer.fromJson<String>(json['capitalName']),
      capitalMinorUnits: serializer.fromJson<int>(json['capitalMinorUnits']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'capitalName': serializer.toJson<String>(capitalName),
      'capitalMinorUnits': serializer.toJson<int>(capitalMinorUnits),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith({
    int? id,
    String? name,
    String? capitalName,
    int? capitalMinorUnits,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Profile(
    id: id ?? this.id,
    name: name ?? this.name,
    capitalName: capitalName ?? this.capitalName,
    capitalMinorUnits: capitalMinorUnits ?? this.capitalMinorUnits,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      capitalName: data.capitalName.present
          ? data.capitalName.value
          : this.capitalName,
      capitalMinorUnits: data.capitalMinorUnits.present
          ? data.capitalMinorUnits.value
          : this.capitalMinorUnits,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('capitalName: $capitalName, ')
          ..write('capitalMinorUnits: $capitalMinorUnits, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    capitalName,
    capitalMinorUnits,
    isFavorite,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.name == this.name &&
          other.capitalName == this.capitalName &&
          other.capitalMinorUnits == this.capitalMinorUnits &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> capitalName;
  final Value<int> capitalMinorUnits;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.capitalName = const Value.absent(),
    this.capitalMinorUnits = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String capitalName,
    required int capitalMinorUnits,
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       capitalName = Value(capitalName),
       capitalMinorUnits = Value(capitalMinorUnits);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? capitalName,
    Expression<int>? capitalMinorUnits,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (capitalName != null) 'capital_name': capitalName,
      if (capitalMinorUnits != null) 'capital_minor_units': capitalMinorUnits,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? capitalName,
    Value<int>? capitalMinorUnits,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      capitalName: capitalName ?? this.capitalName,
      capitalMinorUnits: capitalMinorUnits ?? this.capitalMinorUnits,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (capitalName.present) {
      map['capital_name'] = Variable<String>(capitalName.value);
    }
    if (capitalMinorUnits.present) {
      map['capital_minor_units'] = Variable<int>(capitalMinorUnits.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('capitalName: $capitalName, ')
          ..write('capitalMinorUnits: $capitalMinorUnits, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SplittersTable extends Splitters
    with TableInfo<$SplittersTable, Splitter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SplittersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  @override
  late final GeneratedColumn<int> percentage = GeneratedColumn<int>(
    'percentage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (percentage BETWEEN 1 AND 100)',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (sort_order >= 0)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    percentage,
    name,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'splitters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Splitter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Splitter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Splitter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}percentage'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SplittersTable createAlias(String alias) {
    return $SplittersTable(attachedDatabase, alias);
  }
}

class Splitter extends DataClass implements Insertable<Splitter> {
  final int id;
  final int profileId;
  final int percentage;
  final String name;
  final int sortOrder;
  const Splitter({
    required this.id,
    required this.profileId,
    required this.percentage,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<int>(profileId);
    map['percentage'] = Variable<int>(percentage);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SplittersCompanion toCompanion(bool nullToAbsent) {
    return SplittersCompanion(
      id: Value(id),
      profileId: Value(profileId),
      percentage: Value(percentage),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory Splitter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Splitter(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<int>(json['profileId']),
      percentage: serializer.fromJson<int>(json['percentage']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<int>(profileId),
      'percentage': serializer.toJson<int>(percentage),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Splitter copyWith({
    int? id,
    int? profileId,
    int? percentage,
    String? name,
    int? sortOrder,
  }) => Splitter(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    percentage: percentage ?? this.percentage,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Splitter copyWithCompanion(SplittersCompanion data) {
    return Splitter(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Splitter(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('percentage: $percentage, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, percentage, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Splitter &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.percentage == this.percentage &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class SplittersCompanion extends UpdateCompanion<Splitter> {
  final Value<int> id;
  final Value<int> profileId;
  final Value<int> percentage;
  final Value<String> name;
  final Value<int> sortOrder;
  const SplittersCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.percentage = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  SplittersCompanion.insert({
    this.id = const Value.absent(),
    required int profileId,
    required int percentage,
    required String name,
    required int sortOrder,
  }) : profileId = Value(profileId),
       percentage = Value(percentage),
       name = Value(name),
       sortOrder = Value(sortOrder);
  static Insertable<Splitter> custom({
    Expression<int>? id,
    Expression<int>? profileId,
    Expression<int>? percentage,
    Expression<String>? name,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (percentage != null) 'percentage': percentage,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  SplittersCompanion copyWith({
    Value<int>? id,
    Value<int>? profileId,
    Value<int>? percentage,
    Value<String>? name,
    Value<int>? sortOrder,
  }) {
    return SplittersCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      percentage: percentage ?? this.percentage,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<int>(percentage.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SplittersCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('percentage: $percentage, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ProfileThemesTable extends ProfileThemes
    with TableInfo<$ProfileThemesTable, ProfileTheme> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileThemesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isAutoMeta = const VerificationMeta('isAuto');
  @override
  late final GeneratedColumn<bool> isAuto = GeneratedColumn<bool>(
    'is_auto',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_auto" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDarkMeta = const VerificationMeta('isDark');
  @override
  late final GeneratedColumn<bool> isDark = GeneratedColumn<bool>(
    'is_dark',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dark" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, profileId, isAuto, isDark];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_themes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileTheme> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('is_auto')) {
      context.handle(
        _isAutoMeta,
        isAuto.isAcceptableOrUnknown(data['is_auto']!, _isAutoMeta),
      );
    }
    if (data.containsKey('is_dark')) {
      context.handle(
        _isDarkMeta,
        isDark.isAcceptableOrUnknown(data['is_dark']!, _isDarkMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileTheme map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileTheme(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      isAuto: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_auto'],
      )!,
      isDark: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dark'],
      )!,
    );
  }

  @override
  $ProfileThemesTable createAlias(String alias) {
    return $ProfileThemesTable(attachedDatabase, alias);
  }
}

class ProfileTheme extends DataClass implements Insertable<ProfileTheme> {
  final int id;
  final int profileId;
  final bool isAuto;
  final bool isDark;
  const ProfileTheme({
    required this.id,
    required this.profileId,
    required this.isAuto,
    required this.isDark,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<int>(profileId);
    map['is_auto'] = Variable<bool>(isAuto);
    map['is_dark'] = Variable<bool>(isDark);
    return map;
  }

  ProfileThemesCompanion toCompanion(bool nullToAbsent) {
    return ProfileThemesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      isAuto: Value(isAuto),
      isDark: Value(isDark),
    );
  }

  factory ProfileTheme.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileTheme(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<int>(json['profileId']),
      isAuto: serializer.fromJson<bool>(json['isAuto']),
      isDark: serializer.fromJson<bool>(json['isDark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<int>(profileId),
      'isAuto': serializer.toJson<bool>(isAuto),
      'isDark': serializer.toJson<bool>(isDark),
    };
  }

  ProfileTheme copyWith({
    int? id,
    int? profileId,
    bool? isAuto,
    bool? isDark,
  }) => ProfileTheme(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    isAuto: isAuto ?? this.isAuto,
    isDark: isDark ?? this.isDark,
  );
  ProfileTheme copyWithCompanion(ProfileThemesCompanion data) {
    return ProfileTheme(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      isAuto: data.isAuto.present ? data.isAuto.value : this.isAuto,
      isDark: data.isDark.present ? data.isDark.value : this.isDark,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTheme(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('isAuto: $isAuto, ')
          ..write('isDark: $isDark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, isAuto, isDark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileTheme &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.isAuto == this.isAuto &&
          other.isDark == this.isDark);
}

class ProfileThemesCompanion extends UpdateCompanion<ProfileTheme> {
  final Value<int> id;
  final Value<int> profileId;
  final Value<bool> isAuto;
  final Value<bool> isDark;
  const ProfileThemesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.isAuto = const Value.absent(),
    this.isDark = const Value.absent(),
  });
  ProfileThemesCompanion.insert({
    this.id = const Value.absent(),
    required int profileId,
    this.isAuto = const Value.absent(),
    this.isDark = const Value.absent(),
  }) : profileId = Value(profileId);
  static Insertable<ProfileTheme> custom({
    Expression<int>? id,
    Expression<int>? profileId,
    Expression<bool>? isAuto,
    Expression<bool>? isDark,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (isAuto != null) 'is_auto': isAuto,
      if (isDark != null) 'is_dark': isDark,
    });
  }

  ProfileThemesCompanion copyWith({
    Value<int>? id,
    Value<int>? profileId,
    Value<bool>? isAuto,
    Value<bool>? isDark,
  }) {
    return ProfileThemesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      isAuto: isAuto ?? this.isAuto,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (isAuto.present) {
      map['is_auto'] = Variable<bool>(isAuto.value);
    }
    if (isDark.present) {
      map['is_dark'] = Variable<bool>(isDark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileThemesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('isAuto: $isAuto, ')
          ..write('isDark: $isDark')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $SplittersTable splitters = $SplittersTable(this);
  late final $ProfileThemesTable profileThemes = $ProfileThemesTable(this);
  late final Index splittersProfileOrder = Index(
    'splitters_profile_order',
    'CREATE INDEX splitters_profile_order ON splitters (profile_id, sort_order)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    splitters,
    profileThemes,
    splittersProfileOrder,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('splitters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_themes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      required String name,
      required String capitalName,
      required int capitalMinorUnits,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> capitalName,
      Value<int> capitalMinorUnits,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $ProfilesTable, Profile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SplittersTable, List<Splitter>>
  _splittersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.splitters,
    aliasName: 'profiles__id__splitters__profile_id',
  );

  $$SplittersTableProcessedTableManager get splittersRefs {
    final manager = $$SplittersTableTableManager(
      $_db,
      $_db.splitters,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_splittersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProfileThemesTable, List<ProfileTheme>>
  _profileThemesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.profileThemes,
    aliasName: 'profiles__id__profile_themes__profile_id',
  );

  $$ProfileThemesTableProcessedTableManager get profileThemesRefs {
    final manager = $$ProfileThemesTableTableManager(
      $_db,
      $_db.profileThemes,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_profileThemesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get capitalName => $composableBuilder(
    column: $table.capitalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capitalMinorUnits => $composableBuilder(
    column: $table.capitalMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> splittersRefs(
    Expression<bool> Function($$SplittersTableFilterComposer f) f,
  ) {
    final $$SplittersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.splitters,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SplittersTableFilterComposer(
            $db: $db,
            $table: $db.splitters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> profileThemesRefs(
    Expression<bool> Function($$ProfileThemesTableFilterComposer f) f,
  ) {
    final $$ProfileThemesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileThemes,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileThemesTableFilterComposer(
            $db: $db,
            $table: $db.profileThemes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get capitalName => $composableBuilder(
    column: $table.capitalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capitalMinorUnits => $composableBuilder(
    column: $table.capitalMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get capitalName => $composableBuilder(
    column: $table.capitalName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get capitalMinorUnits => $composableBuilder(
    column: $table.capitalMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> splittersRefs<T extends Object>(
    Expression<T> Function($$SplittersTableAnnotationComposer a) f,
  ) {
    final $$SplittersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.splitters,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SplittersTableAnnotationComposer(
            $db: $db,
            $table: $db.splitters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> profileThemesRefs<T extends Object>(
    Expression<T> Function($$ProfileThemesTableAnnotationComposer a) f,
  ) {
    final $$ProfileThemesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileThemes,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileThemesTableAnnotationComposer(
            $db: $db,
            $table: $db.profileThemes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, $$ProfilesTableReferences),
          Profile,
          PrefetchHooks Function({bool splittersRefs, bool profileThemesRefs})
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> capitalName = const Value.absent(),
                Value<int> capitalMinorUnits = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                name: name,
                capitalName: capitalName,
                capitalMinorUnits: capitalMinorUnits,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String capitalName,
                required int capitalMinorUnits,
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                name: name,
                capitalName: capitalName,
                capitalMinorUnits: capitalMinorUnits,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({splittersRefs = false, profileThemesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (splittersRefs) db.splitters,
                    if (profileThemesRefs) db.profileThemes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (splittersRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          Splitter
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._splittersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).splittersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (profileThemesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          ProfileTheme
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._profileThemesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).profileThemesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, $$ProfilesTableReferences),
      Profile,
      PrefetchHooks Function({bool splittersRefs, bool profileThemesRefs})
    >;
typedef $$SplittersTableCreateCompanionBuilder =
    SplittersCompanion Function({
      Value<int> id,
      required int profileId,
      required int percentage,
      required String name,
      required int sortOrder,
    });
typedef $$SplittersTableUpdateCompanionBuilder =
    SplittersCompanion Function({
      Value<int> id,
      Value<int> profileId,
      Value<int> percentage,
      Value<String> name,
      Value<int> sortOrder,
    });

final class $$SplittersTableReferences
    extends BaseReferences<_$AppDatabase, $SplittersTable, Splitter> {
  $$SplittersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('splitters__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SplittersTableFilterComposer
    extends Composer<_$AppDatabase, $SplittersTable> {
  $$SplittersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SplittersTableOrderingComposer
    extends Composer<_$AppDatabase, $SplittersTable> {
  $$SplittersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SplittersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SplittersTable> {
  $$SplittersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SplittersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SplittersTable,
          Splitter,
          $$SplittersTableFilterComposer,
          $$SplittersTableOrderingComposer,
          $$SplittersTableAnnotationComposer,
          $$SplittersTableCreateCompanionBuilder,
          $$SplittersTableUpdateCompanionBuilder,
          (Splitter, $$SplittersTableReferences),
          Splitter,
          PrefetchHooks Function({bool profileId})
        > {
  $$SplittersTableTableManager(_$AppDatabase db, $SplittersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SplittersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SplittersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SplittersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> profileId = const Value.absent(),
                Value<int> percentage = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SplittersCompanion(
                id: id,
                profileId: profileId,
                percentage: percentage,
                name: name,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int profileId,
                required int percentage,
                required String name,
                required int sortOrder,
              }) => SplittersCompanion.insert(
                id: id,
                profileId: profileId,
                percentage: percentage,
                name: name,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SplittersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$SplittersTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$SplittersTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SplittersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SplittersTable,
      Splitter,
      $$SplittersTableFilterComposer,
      $$SplittersTableOrderingComposer,
      $$SplittersTableAnnotationComposer,
      $$SplittersTableCreateCompanionBuilder,
      $$SplittersTableUpdateCompanionBuilder,
      (Splitter, $$SplittersTableReferences),
      Splitter,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$ProfileThemesTableCreateCompanionBuilder =
    ProfileThemesCompanion Function({
      Value<int> id,
      required int profileId,
      Value<bool> isAuto,
      Value<bool> isDark,
    });
typedef $$ProfileThemesTableUpdateCompanionBuilder =
    ProfileThemesCompanion Function({
      Value<int> id,
      Value<int> profileId,
      Value<bool> isAuto,
      Value<bool> isDark,
    });

final class $$ProfileThemesTableReferences
    extends BaseReferences<_$AppDatabase, $ProfileThemesTable, ProfileTheme> {
  $$ProfileThemesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('profile_themes__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProfileThemesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileThemesTable> {
  $$ProfileThemesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAuto => $composableBuilder(
    column: $table.isAuto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDark => $composableBuilder(
    column: $table.isDark,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileThemesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileThemesTable> {
  $$ProfileThemesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAuto => $composableBuilder(
    column: $table.isAuto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDark => $composableBuilder(
    column: $table.isDark,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileThemesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileThemesTable> {
  $$ProfileThemesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAuto =>
      $composableBuilder(column: $table.isAuto, builder: (column) => column);

  GeneratedColumn<bool> get isDark =>
      $composableBuilder(column: $table.isDark, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileThemesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileThemesTable,
          ProfileTheme,
          $$ProfileThemesTableFilterComposer,
          $$ProfileThemesTableOrderingComposer,
          $$ProfileThemesTableAnnotationComposer,
          $$ProfileThemesTableCreateCompanionBuilder,
          $$ProfileThemesTableUpdateCompanionBuilder,
          (ProfileTheme, $$ProfileThemesTableReferences),
          ProfileTheme,
          PrefetchHooks Function({bool profileId})
        > {
  $$ProfileThemesTableTableManager(_$AppDatabase db, $ProfileThemesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileThemesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileThemesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileThemesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> profileId = const Value.absent(),
                Value<bool> isAuto = const Value.absent(),
                Value<bool> isDark = const Value.absent(),
              }) => ProfileThemesCompanion(
                id: id,
                profileId: profileId,
                isAuto: isAuto,
                isDark: isDark,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int profileId,
                Value<bool> isAuto = const Value.absent(),
                Value<bool> isDark = const Value.absent(),
              }) => ProfileThemesCompanion.insert(
                id: id,
                profileId: profileId,
                isAuto: isAuto,
                isDark: isDark,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfileThemesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$ProfileThemesTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$ProfileThemesTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProfileThemesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileThemesTable,
      ProfileTheme,
      $$ProfileThemesTableFilterComposer,
      $$ProfileThemesTableOrderingComposer,
      $$ProfileThemesTableAnnotationComposer,
      $$ProfileThemesTableCreateCompanionBuilder,
      $$ProfileThemesTableUpdateCompanionBuilder,
      (ProfileTheme, $$ProfileThemesTableReferences),
      ProfileTheme,
      PrefetchHooks Function({bool profileId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$SplittersTableTableManager get splitters =>
      $$SplittersTableTableManager(_db, _db.splitters);
  $$ProfileThemesTableTableManager get profileThemes =>
      $$ProfileThemesTableTableManager(_db, _db.profileThemes);
}
