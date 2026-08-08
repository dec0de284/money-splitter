import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../data/profile_repository.dart';
import '../profiles/profiles_screen.dart';
import 'editor_controller.dart';
import 'splitter_row.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({
    super.key,
    required this.repository,
    this.themeMode = ThemeMode.system,
    this.onThemeModeChanged,
  });

  final ProfileRepository repository;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late final EditorController _controller;
  late final TextEditingController _profileNameController;
  late final TextEditingController _capitalNameController;
  late final TextEditingController _capitalController;
  final _currency = NumberFormat.currency(locale: 'en_PH', symbol: '₱');

  @override
  void initState() {
    super.initState();
    _controller = EditorController(widget.repository)..addListener(_refresh);
    _profileNameController = TextEditingController();
    _capitalNameController = TextEditingController();
    _capitalController = TextEditingController();
    _loadStartupProfile();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_refresh)
      ..dispose();
    _profileNameController.dispose();
    _capitalNameController.dispose();
    _capitalController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final allocation = _controller.allocation;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<ThemeMode>(
            initialValue: widget.themeMode,
            onSelected: _setThemeMode,
            tooltip: 'Theme',
            icon: Icon(_themeIcon(widget.themeMode)),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: ThemeMode.system,
                child: ListTile(
                  leading: Icon(Icons.brightness_auto_outlined),
                  title: Text('System'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: ListTile(
                  leading: Icon(Icons.light_mode_outlined),
                  title: Text('Light'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: ListTile(
                  leading: Icon(Icons.dark_mode_outlined),
                  title: Text('Dark'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _controller.isSaving ? null : _save,
            tooltip: 'Save profile',
            icon: _controller.isSaving
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
          ),
          IconButton(
            onPressed: _openProfiles,
            tooltip: 'Manage profiles',
            icon: const Icon(Icons.folder_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              children: [
                TextField(
                  controller: _profileNameController,
                  decoration: const InputDecoration(
                    labelText: 'Profile name',
                    prefixIcon: Icon(Icons.bookmark_outline),
                  ),
                  maxLength: 80,
                  textInputAction: TextInputAction.next,
                  onChanged: _controller.setProfileName,
                ),
                const SizedBox(height: 12),
                _capitalSection(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Splits',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: _controller.canAddSplitter
                          ? _controller.addSplitter
                          : null,
                      tooltip: 'Add split',
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (_controller.splitters.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text('Add a split to start allocating.'),
                    ),
                  ),
                for (final (index, draft) in _controller.splitters.indexed) ...[
                  SplitterRow(
                    key: ValueKey(draft.localId),
                    draft: draft,
                    amountLabel: _currency.format(
                      allocation.amounts[index] / 100,
                    ),
                    maximum: _controller.maximumFor(draft.localId),
                    onNameChanged: (value) =>
                        _controller.updateSplitterName(draft.localId, value),
                    onPercentageChanged: (value) => _controller
                        .updateSplitterPercentage(draft.localId, value),
                    onDelete: () => _controller.removeSplitter(draft.localId),
                  ),
                  const SizedBox(height: 12),
                ],
                _summary(allocation.remainingAmount),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _capitalSection() {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Capital',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: _resetCapital,
                tooltip: 'Clear capital and splits',
                icon: const Icon(Icons.delete_sweep_outlined),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _capitalController,
            decoration: const InputDecoration(
              labelText: 'Amount',
              prefixText: '₱ ',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ThousandsSeparatorInputFormatter()],
            textInputAction: TextInputAction.next,
            onChanged: (value) =>
                _controller.setCapitalMinorUnits(_parseMinorUnits(value)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _capitalNameController,
            decoration: const InputDecoration(labelText: 'Capital name'),
            maxLength: 80,
            onChanged: _controller.setCapitalName,
          ),
        ],
      ),
    );
  }

  Widget _summary(int remainingAmount) {
    final colors = Theme.of(context).colorScheme;
    final allocatedAmount = _controller.capitalMinorUnits - remainingAmount;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _summaryLine(
            'Allocated · ${_controller.allocatedPercentage}%',
            _currency.format(allocatedAmount / 100),
          ),
          const Divider(height: 24),
          _summaryLine(
            'Remaining · ${_controller.remainingPercentage}%',
            _currency.format(remainingAmount / 100),
          ),
        ],
      ),
    );
  }

  Widget _summaryLine(String label, String amount) => Row(
    children: [
      Expanded(child: Text(label)),
      Text(amount, style: const TextStyle(fontWeight: FontWeight.w700)),
    ],
  );

  Future<void> _save() async {
    try {
      final result = await _controller.save();
      await _persistTheme(result.profileId, widget.themeMode);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.wasCreated ? 'New profile created' : 'Profile saved.',
          ),
        ),
      );
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$error')));
    }
  }

  Future<void> _openProfiles() async {
    final selectedId = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => ProfilesScreen(repository: widget.repository),
      ),
    );
    if (selectedId == null || !mounted) return;
    if (_controller.isDirty && !await _confirmDiscard()) return;

    if (selectedId == -1) {
      _controller.newDraft();
      widget.onThemeModeChanged?.call(ThemeMode.system);
    } else {
      await _controller.loadProfile(selectedId);
      await _loadTheme(selectedId);
    }
    _syncTextFields();
  }

  Future<bool> _confirmDiscard() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Discard unsaved changes?'),
            content: const Text('Your current draft has not been saved.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Stay'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Discard'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _resetCapital() {
    _controller.resetCapitalAndSplitters();
    _capitalController.clear();
    _capitalNameController.clear();
  }

  void _syncTextFields() {
    _profileNameController.text = _controller.profileName;
    _capitalNameController.text = _controller.capitalName;
    _capitalController.text = _controller.capitalMinorUnits == 0
        ? ''
        : NumberFormat('#,##0.00').format(_controller.capitalMinorUnits / 100);
  }

  int _parseMinorUnits(String input) {
    final normalized = input.replaceAll(',', '').trim();
    final parts = normalized.split('.');
    final whole = int.tryParse(parts.first) ?? 0;
    final fractionText = parts.length > 1 ? parts[1] : '';
    final fraction =
        int.tryParse(fractionText.padRight(2, '0').substring(0, 2)) ?? 0;
    return whole * 100 + fraction;
  }

  Future<void> _loadStartupProfile() async {
    final loaded = await _controller.loadStartupProfile();
    if (!mounted || !loaded) return;
    _syncTextFields();
    final preference = _controller.startupTheme!;
    widget.onThemeModeChanged?.call(
      preference.isAuto
          ? ThemeMode.system
          : preference.isDark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  Future<void> _loadTheme(int profileId) async {
    final preference = await widget.repository.loadTheme(profileId);
    if (!mounted) return;
    widget.onThemeModeChanged?.call(
      preference.isAuto
          ? ThemeMode.system
          : preference.isDark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  Future<void> _setThemeMode(ThemeMode mode) async {
    widget.onThemeModeChanged?.call(mode);
    final profileId = _controller.profileId;
    if (profileId != null) await _persistTheme(profileId, mode);
  }

  Future<void> _persistTheme(int profileId, ThemeMode mode) {
    return widget.repository.setTheme(
      profileId,
      isAuto: mode == ThemeMode.system,
      isDark: mode == ThemeMode.dark,
    );
  }

  IconData _themeIcon(ThemeMode mode) => switch (mode) {
    ThemeMode.system => Icons.brightness_auto_outlined,
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
  };
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  ThousandsSeparatorInputFormatter()
    : _wholeNumberFormat = NumberFormat('#,##0');

  final NumberFormat _wholeNumberFormat;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final raw = newValue.text.replaceAll(',', '');
    if (raw.isEmpty) return newValue;
    if (!RegExp(r'^\d*(\.\d{0,2})?$').hasMatch(raw)) return oldValue;

    final parts = raw.split('.');
    final whole = int.tryParse(parts.first) ?? 0;
    final formattedWhole = _wholeNumberFormat.format(whole);
    final formatted = parts.length == 1
        ? formattedWhole
        : '$formattedWhole.${parts[1]}';
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
