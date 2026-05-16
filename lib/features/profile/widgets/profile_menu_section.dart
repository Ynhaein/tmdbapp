import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  static const List<_MenuItemData> _menuItems = [
    _MenuItemData(
      icon: Icons.person_outlined,
      label: 'Edit Profile',
      showDivider: true,
    ),
    _MenuItemData(
      icon: Icons.rate_review_outlined,
      label: 'My Reviews',
      showDivider: true,
    ),
    _MenuItemData(
      icon: Icons.payment_outlined,
      label: 'Payment Methods',
      showDivider: true,
    ),
    _MenuItemData(
      icon: Icons.settings_outlined,
      label: 'Settings',
      showDivider: true,
    ),
    _MenuItemData(
      icon: Icons.help_outline_rounded,
      label: 'Help & Support',
      showDivider: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        children: _menuItems
            .map((item) => _MenuTile(data: item))
            .toList(),
      ),
    );
  }
}

// ─── Private Widgets ──────────────────────────────────────────────

class _MenuItemData {
  final IconData icon;
  final String label;
  final bool showDivider;

  const _MenuItemData({
    required this.icon,
    required this.label,
    required this.showDivider,
  });
}

class _MenuTile extends StatelessWidget {
  final _MenuItemData data;

  const _MenuTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMedium,
              vertical: AppDimens.paddingMedium + 5,
            ),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: AppDimens.avatarSmall,
                  height: AppDimens.avatarSmall,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                    border: Border.all(
                      color: AppColors.divider,
                      width: 0.5,
                    ),
                  ),
                  child: Icon(
                    data.icon,
                    color: AppColors.iconPrimary,
                    size: AppDimens.iconSmall,
                  ),
                ),

                const SizedBox(width: AppDimens.gapMedium),

                // Label
                Expanded(
                  child: Text(
                    data.label,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimens.fontSizeBase,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Arrow
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.iconSecondary,
                  size: AppDimens.iconMedium,
                ),
              ],
            ),
          ),
        ),

        if (data.showDivider)
          const Divider(
            color: AppColors.divider,
            height: 1,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          ),
      ],
    );
  }
}