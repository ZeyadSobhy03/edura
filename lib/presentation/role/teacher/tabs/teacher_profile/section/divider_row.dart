import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorManager.black.withValues(alpha: 0.1),
      thickness: 1,
      height: 24,
    );
  }
}
