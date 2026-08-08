import 'package:flutter/foundation.dart';

import '../../data/profile_repository.dart';
import '../../domain/allocation_calculator.dart';

class SplitterDraft {
  const SplitterDraft({
    required this.localId,
    this.name = '',
    this.percentage = 0,
  });

  final int localId;
  final String name;
  final int percentage;

  SplitterDraft copyWith({String? name, int? percentage}) => SplitterDraft(
    localId: localId,
    name: name ?? this.name,
    percentage: percentage ?? this.percentage,
  );
}

class EditorController extends ChangeNotifier {
  EditorController(this._repository);

  final ProfileRepository _repository;
  final List<SplitterDraft> _splitters = [];
  int _nextLocalId = 0;

  int? profileId;
  String profileName = '';
  String capitalName = '';
  int capitalMinorUnits = 0;
  bool isDirty = false;
  bool isSaving = false;
  ProfileThemePreference? startupTheme;

  List<SplitterDraft> get splitters => List.unmodifiable(_splitters);
  int get allocatedPercentage =>
      _splitters.fold(0, (sum, row) => sum + row.percentage);
  int get remainingPercentage => 100 - allocatedPercentage;
  bool get canAddSplitter =>
      remainingPercentage > 0 &&
      _splitters.every(
        (row) => row.name.trim().isNotEmpty && row.percentage > 0,
      );

  AllocationResult get allocation => AllocationCalculator.calculate(
    capitalMinorUnits: capitalMinorUnits,
    percentages: _splitters.map((row) => row.percentage).toList(),
  );

  void setProfileName(String value) {
    profileName = value;
    _markDirty();
  }

  void setCapitalName(String value) {
    capitalName = value;
    _markDirty();
  }

  void setCapitalMinorUnits(int value) {
    capitalMinorUnits = value;
    _markDirty();
  }

  void addSplitter() {
    if (!canAddSplitter && _splitters.isNotEmpty) return;
    _splitters.add(SplitterDraft(localId: _nextLocalId++));
    _markDirty();
  }

  void updateSplitterName(int localId, String value) {
    final index = _indexOf(localId);
    _splitters[index] = _splitters[index].copyWith(name: value);
    _markDirty();
  }

  void updateSplitterPercentage(int localId, int value) {
    final index = _indexOf(localId);
    final maximum = maximumFor(localId);
    _splitters[index] = _splitters[index].copyWith(
      percentage: value.clamp(0, maximum),
    );
    _markDirty();
  }

  int maximumFor(int localId) {
    final index = _indexOf(localId);
    return AllocationCalculator.maximumFor(
      _splitters.map((row) => row.percentage).toList(),
      index,
    );
  }

  void removeSplitter(int localId) {
    _splitters.removeAt(_indexOf(localId));
    _markDirty();
  }

  void resetCapitalAndSplitters() {
    capitalName = '';
    capitalMinorUnits = 0;
    _splitters.clear();
    _markDirty();
  }

  void newDraft() {
    profileId = null;
    profileName = '';
    capitalName = '';
    capitalMinorUnits = 0;
    _splitters.clear();
    isDirty = false;
    notifyListeners();
  }

  Future<bool> loadStartupProfile() async {
    final startup = await _repository.loadStartupProfile();
    if (startup == null) return false;
    startupTheme = startup.theme;
    _applyAggregate(startup.aggregate);
    return true;
  }

  Future<void> loadProfile(int id) async {
    final aggregate = await _repository.loadProfile(id);
    if (aggregate == null) throw StateError('That profile no longer exists.');

    _applyAggregate(aggregate);
  }

  void _applyAggregate(ProfileAggregate aggregate) {
    profileId = aggregate.profile.id;
    profileName = aggregate.profile.name;
    capitalName = aggregate.profile.capitalName;
    capitalMinorUnits = aggregate.profile.capitalMinorUnits;
    _splitters
      ..clear()
      ..addAll(
        aggregate.splitters.map(
          (row) => SplitterDraft(
            localId: _nextLocalId++,
            name: row.name,
            percentage: row.percentage,
          ),
        ),
      );
    isDirty = false;
    notifyListeners();
  }

  Future<ProfileSaveResult> save() async {
    if (isSaving) throw StateError('A save is already in progress.');
    isSaving = true;
    notifyListeners();
    try {
      final result = await _repository.saveProfile(
        profileId: profileId,
        name: profileName,
        capitalName: capitalName,
        capitalMinorUnits: capitalMinorUnits,
        splitters: _splitters
            .map(
              (row) =>
                  SplitterDraftData(name: row.name, percentage: row.percentage),
            )
            .toList(),
      );
      profileId = result.profileId;
      isDirty = false;
      return result;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  int _indexOf(int localId) {
    final index = _splitters.indexWhere((row) => row.localId == localId);
    if (index < 0) throw StateError('Splitter $localId does not exist.');
    return index;
  }

  void _markDirty() {
    isDirty = true;
    notifyListeners();
  }
}
