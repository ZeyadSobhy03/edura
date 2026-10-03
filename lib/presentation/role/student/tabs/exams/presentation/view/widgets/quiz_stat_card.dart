import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class QuizStatCard extends StatelessWidget {
  const QuizStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ColorManager.black.withValues(alpha: 0.1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      color: ColorManager.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Text('$value', style: TextStyle(color: color, fontSize: 14)),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: ColorManager.salatGray,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
