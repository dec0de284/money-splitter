import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'editor_controller.dart';

class SplitterRow extends StatefulWidget {
  const SplitterRow({
    super.key,
    required this.draft,
    required this.amountLabel,
    required this.maximum,
    required this.onNameChanged,
    required this.onPercentageChanged,
    required this.onDelete,
  });

  final SplitterDraft draft;
  final String amountLabel;
  final int maximum;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<int> onPercentageChanged;
  final VoidCallback onDelete;

  @override
  State<SplitterRow> createState() => _SplitterRowState();
}

class _SplitterRowState extends State<SplitterRow> {
  late final TextEditingController _percentageController;

  @override
  void initState() {
    super.initState();
    _percentageController = TextEditingController(
      text: widget.draft.percentage == 0 ? '' : '${widget.draft.percentage}',
    );
  }

  @override
  void didUpdateWidget(covariant SplitterRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.draft.percentage != widget.draft.percentage) {
      final text = widget.draft.percentage == 0
          ? ''
          : '${widget.draft.percentage}';
      _percentageController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  void dispose() {
    _percentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  key: ValueKey('name-${widget.draft.localId}'),
                  initialValue: widget.draft.name,
                  decoration: const InputDecoration(labelText: 'Split name'),
                  textInputAction: TextInputAction.next,
                  maxLength: 80,
                  onChanged: widget.onNameChanged,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: widget.onDelete,
                tooltip: 'Delete split',
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 92,
                child: TextField(
                  controller: _percentageController,
                  decoration: const InputDecoration(
                    labelText: 'Percent',
                    suffixText: '%',
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  onChanged: (text) =>
                      widget.onPercentageChanged(int.tryParse(text) ?? 0),
                ),
              ),
              const Spacer(),
              Text(
                widget.amountLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: widget.maximum == 0
                    ? null
                    : () => widget.onPercentageChanged(1),
                tooltip: 'Set minimum percentage',
                icon: const Icon(Icons.first_page),
              ),
              Expanded(
                child: Slider(
                  value: widget.draft.percentage.toDouble().clamp(
                    0,
                    widget.maximum.toDouble(),
                  ),
                  min: 0,
                  max: widget.maximum == 0 ? 1 : widget.maximum.toDouble(),
                  label: '${widget.draft.percentage}%',
                  onChanged: widget.maximum == 0
                      ? null
                      : (value) => widget.onPercentageChanged(value.round()),
                ),
              ),
              IconButton(
                onPressed: widget.maximum == 0
                    ? null
                    : () => widget.onPercentageChanged(widget.maximum),
                tooltip: 'Set maximum percentage',
                icon: const Icon(Icons.last_page),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Maximum ${widget.maximum}%')],
          ),
        ],
      ),
    );
  }
}
