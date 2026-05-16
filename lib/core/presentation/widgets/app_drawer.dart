import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const List<_DrawerMenuItem> _menuItems = [
    _DrawerMenuItem(
      icon: Icons.edit_outlined,
      label: 'Edit Profile',
    ),
    _DrawerMenuItem(
      icon: Icons.rate_review_outlined,
      label: 'My Reviews',
    ),
    _DrawerMenuItem(
      icon: Icons.payment_outlined,
      label: 'Payment Methods',
    ),
    _DrawerMenuItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
    ),
    _DrawerMenuItem(
      icon: Icons.help_outline_rounded,
      label: 'Help & Support',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,

      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppDimens.radiusExtraLarge),
          bottomRight: Radius.circular(AppDimens.radiusExtraLarge),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryDark,

            border: const Border(
              right: BorderSide(
                color: AppColors.outline,
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _DrawerHeader(),

                const Divider(
                  color: AppColors.outline,
                  thickness: 0.5,
                  indent: AppDimens.paddingMedium,
                  endIndent: AppDimens.paddingMedium,
                ),

                const SizedBox(height: AppDimens.gapSmall),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.paddingMedium,
                    ),
                    itemCount: _menuItems.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppDimens.gapXsmall),
                    itemBuilder: (context, index) {
                      return _DrawerMenuTile(item: _menuItems[index]);
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(AppDimens.paddingMedium),
                  child: Text(
                    'TMDB Cinema v1.0.0',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimens.fontSizeXs,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLarge),
      child: Row(
        children: [
          Container(
            width: AppDimens.avatarLarge,
            height: AppDimens.avatarLarge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundPrimary,
              border: Border.all(
                color: AppColors.primary,
                width: 2.5,
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.textPrimary,
              size: AppDimens.iconLarge,
            ),
          ),

          const SizedBox(width: AppDimens.gapMedium),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ynhaein',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppDimens.fontSizeLarge,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppDimens.gapXsmall),
              Text(
                'ynhaein@gmail.com',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppDimens.fontSizeXs,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Menu Tile ───────────────────────────────────────────

class _DrawerMenuTile extends StatelessWidget {
  final _DrawerMenuItem item;

  const _DrawerMenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
      leading: Icon(
        item.icon,
        color: AppColors.iconPrimary,
        size: AppDimens.iconMedium,
      ),
      title: Text(
        item.label,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: AppDimens.fontSizeBase,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.iconSecondary,
        size: AppDimens.iconMedium,
      ),
    );
  }
}

// ─── Model ───────────────────────────────────────────────

class _DrawerMenuItem {
  final IconData icon;
  final String label;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
  });
}