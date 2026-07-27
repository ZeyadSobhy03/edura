import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class LessonNotesTab extends StatefulWidget {
  const LessonNotesTab({super.key, this.initialNote, this.onSave});

  final String? initialNote;
  final ValueChanged<String>? onSave;

  @override
  State<LessonNotesTab> createState() => _LessonNotesTabState();
}

class _LessonNotesTabState extends State<LessonNotesTab> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialNote,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: CustomText(
            text: l10.personalNotesHint,
            style: TextStyle(color: Colors.brown, fontSize: 13),
          ),
        ),
        const SizedBox(height: 12),
        CustomTextFormedField(
          hintText: l10.personalNotesHint,
          controller: _controller,
          maxLines: 8,
          onChanged: widget.onSave,
        ),
      ],
    );
  }
}
