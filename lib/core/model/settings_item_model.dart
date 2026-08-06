import 'package:flutter/cupertino.dart';

enum SettingsItemType { navigation, toggle, action }

class SettingsItemModel {
  final String id;
  final IconData icon;
  final String title;
  final SettingsItemType type;
  final bool? toggleValue;
  final String? trailingText;
  final Color? iconColor;
  final bool isDestructive;

  SettingsItemModel({
    required this.id,
    required this.icon,
    required this.title,
    required this.type,
    this.toggleValue,
    this.trailingText,
    this.iconColor,
    this.isDestructive = false,
  });
}