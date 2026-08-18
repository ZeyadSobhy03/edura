import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.color,
    required this.navigateTo,
    required this.value,
    required this.label,
    required this.description,
  });

  final IconData icon;
  final Color color;
  final String navigateTo;
  final int value;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorManager.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      color: ColorManager.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),

                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, navigateTo);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.gray.withValues(alpha: 0.5),
                    size: 18,
                  ),
                ),
              ],
            ),
            CustomText(
              text: '$value',
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            CustomText(
              text: label,
              style: TextStyle(color: ColorManager.black, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: CustomText(
                text: description,
                maxLines: 2,
                style: TextStyle(
                  color: ColorManager.black.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
