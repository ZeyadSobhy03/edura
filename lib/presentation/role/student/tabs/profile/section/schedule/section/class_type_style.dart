import 'package:flutter/material.dart';

import '../../../../../../../../core/model/class_schedule_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';


class ClassTypeStyle {
  final Color color;
  final String label;

  const ClassTypeStyle({required this.color, required this.label});

  static ClassTypeStyle of(ClassType type, AppLocalizations l10) {
    switch (type) {
      case ClassType.lecture:
        return ClassTypeStyle(color: Colors.blue, label: l10.classLabel);
      case ClassType.lab:
        return ClassTypeStyle(color: Colors.purple, label: l10.lab);
      case ClassType.exam:
        return ClassTypeStyle(color: Colors.red, label: l10.exams);
    }
  }
}