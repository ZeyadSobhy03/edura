import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/subject_class_model.dart';
import '../../../../../../../l10n/app_localizations.dart';



class AddEditSubjectSheet extends StatefulWidget {
  const AddEditSubjectSheet({super.key, this.existing});

  final SubjectClassModel? existing;

  @override
  State<AddEditSubjectSheet> createState() => _AddEditSubjectSheetState();
}

class _AddEditSubjectSheetState extends State<AddEditSubjectSheet> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existing?.subjectName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final isEditing = widget.existing != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? l10.editSubject : l10.addSubject,
            style: TextStyle(color: ColorManager.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10.subjectNameHint,
              filled: true,
              fillColor: ColorManager.gray.withValues(alpha: 0.06),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text.trim().isEmpty) return;
                Navigator.pop(
                  context,
                  SubjectClassModel(
                    id: widget.existing?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                    subjectName: _nameController.text.trim(),
                    studentsCount: widget.existing?.studentsCount ?? 0,
                    activeClasses: widget.existing?.activeClasses ?? 0,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(l10.save, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}