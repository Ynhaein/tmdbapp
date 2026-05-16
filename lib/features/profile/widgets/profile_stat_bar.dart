import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class ProfileStatBar extends StatelessWidget {
  const ProfileStatBar({super.key});

  static const List<_StatItem> _stats = [
    _StatItem(value: '142', label: 'Watched'),
    _StatItem(value: '38', label: 'Reviews'),
    _StatItem(value: '45', label: 'Watchlist'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Row(
        children: [
          for (int i = 0; i < _stats.length; i++) ...[
            Expanded(child: _StatCell(item: _stats[i])),
            if (i < _stats.length - 1)
              Container(
                width: 0.5,
                height: 36,
                color: AppColors.divider,
              ),
          ],
        ],
      ),
    );
  }
}

// ─── Private Widgets ──────────────────────────────────────────────

class _StatItem {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});
}

class _StatCell extends StatelessWidget {
  final _StatItem item;

  const _StatCell({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          item.value,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: AppDimens.fontSize2xl,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppDimens.gapXsmall),
        Text(
          item.label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppDimens.fontSizeSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}