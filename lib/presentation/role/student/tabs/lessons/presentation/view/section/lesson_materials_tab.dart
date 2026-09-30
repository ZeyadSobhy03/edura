import 'package:flutter/material.dart';

import 'material_item_card.dart';

class LessonMaterialsTab extends StatelessWidget {
  const LessonMaterialsTab({
    super.key,
    required this.material,
    required this.name,
  });

  final String material;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        MaterialItemCard(material: material, name: name),
      ],
    );
  }
}
