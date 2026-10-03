import 'package:flutter/material.dart';

class NoteFolderStyle {
  final IconData icon;
  final Color color;

  const NoteFolderStyle({required this.icon, required this.color});

  static NoteFolderStyle of(String iconKey) {
    switch (iconKey) {
      case 'mathematics':
        return const NoteFolderStyle(icon: Icons.architecture, color: Colors.blueGrey);
      case 'physics':
        return const NoteFolderStyle(icon: Icons.bolt, color: Colors.orange);
      case 'general':
      default:
        return const NoteFolderStyle(icon: Icons.description_outlined, color: Colors.pink);
    }
  }
}