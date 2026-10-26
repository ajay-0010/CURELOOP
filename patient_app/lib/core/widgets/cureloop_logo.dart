import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class CureLoopLogo extends StatelessWidget {
  const CureLoopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.support, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'CureLoop',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDark,
            fontFamily: AppTypography.fontFamily,
          ),
        ),
      ],
    );
  }
}
