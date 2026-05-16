import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class DetailStatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlight;

  const DetailStatChip({
    super.key,
    required this.icon,
    required this.label,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingSmall,
        vertical: AppDimens.paddingXsmall,
      ),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.primary.withAlpha(20)
            : AppColors.surfaceSecondary.withAlpha(180),
        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
        border: Border.all(
          color: highlight
              ? AppColors.primary.withAlpha(120)
              : AppColors.divider,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: highlight ? AppColors.primary : AppColors.iconPrimary,
            size: AppDimens.iconSmall,
          ),
          const SizedBox(width: AppDimens.gapXsmall),
          Text(
            label,
            style: TextStyle(
              color: highlight ? AppColors.primary : AppColors.textSecondary,
              fontSize: AppDimens.fontSizeXs,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}