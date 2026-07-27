import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/model/lesson_model.dart';
import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class MaterialItemCard extends StatelessWidget {
  const MaterialItemCard({super.key, required this.material});

  final LessonMaterialModel material;

  Future<void> _download() async {
    final uri = Uri.parse(material.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: material.name,
                  style: TextStyle(color: ColorManager.black, fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: '${material.fileType} · ${material.sizeLabel}',
                  style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5), fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.blue),
            onPressed: _download,
          ),
        ],
      ),
    );
  }
}