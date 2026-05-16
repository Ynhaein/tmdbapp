import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; 
  final GlobalKey<ScaffoldState> scaffoldKey; 
  final VoidCallback onAvatarTapped; 

  const CustomAppBar({
    super.key, 
    required this.title, 
    required this.scaffoldKey, 
    required this.onAvatarTapped 
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.barHeight); 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          _HamburgerButton(scaffoldKey : scaffoldKey), 

          Text(
            title, 
            style: const TextStyle(
              color: AppColors.textPrimary, 
              fontSize: AppDimens.fontSizeXl, 
              fontWeight: FontWeight.w600, 
              letterSpacing: 0.5, 
            ),
          ),

          _AvatarButton(onTap: onAvatarTapped) 
        ],
      ),
    );
  }
}

// Private Widgets

class _HamburgerButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey; 

  const _HamburgerButton({required this.scaffoldKey}); 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => scaffoldKey.currentState?.openDrawer(),
      child: Container(
        width: AppDimens.avatarSmall, 
        height: AppDimens.avatarSmall, 
        alignment: Alignment.center, 
        decoration: BoxDecoration(
          color: Colors.transparent, 
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium)
        ),

        child: const Icon(
          Icons.menu, 
          color: AppColors.textPrimary, 
          size: AppDimens.iconMedium,
        ),
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  final VoidCallback onTap; 

  const _AvatarButton({required this.onTap}); 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        width: AppDimens.avatarSmall,
        height: AppDimens.avatarSmall,
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          color: Colors.transparent, 
          border: Border.all(
            color: AppColors.primary, 
            width: 0.5 
          ), 
        ),

        child: const CircleAvatar(
          backgroundColor: AppColors.backgroundSecondary,
          child: Icon(
            Icons.person,
            color: AppColors.textPrimary,
            size: AppDimens.iconMedium,
          ),
        ),
      ),
    );
  }

}
