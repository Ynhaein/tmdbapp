import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Avatar ─────────────────────────────────────────────
        _ProfileAvatar(),

        const SizedBox(height: AppDimens.gapMedium),

        // ── Name & Email ───────────────────────────────────────
        const Text(
          'Ynhaein',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimens.fontSize2xl,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: AppDimens.gapXsmall),

        const Text(
          'ynhaein@gmail.com',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppDimens.fontSizeBase,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: AppDimens.gapSmall),

        // ── Pro Member Badge ───────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
            vertical: AppDimens.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(AppDimens.radiusExtraLarge),
            border: Border.all(
              color: AppColors.primary.withAlpha(80),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.verified_rounded,
                color: AppColors.primary,
                size: AppDimens.iconSmall,
              ),
              const SizedBox(width: AppDimens.gapXsmall),
              const Text(
                'Pro Member',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: AppDimens.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Private Widget ───────────────────────────────────────────────

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Avatar dengan gradient border
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withAlpha(100),
                AppColors.primary,
              ],
            ),
          ),
          child: CircleAvatar(
            radius: AppDimens.avatarMedium,
            backgroundColor: AppColors.surfaceSecondary,
            child: const Icon(
              Icons.person_rounded,
              size: AppDimens.iconXLarge,
              color: AppColors.iconPrimary,
            ),
          ),
        ),

        // Edit Button
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.surfacePrimary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                Icons.edit_outlined,
                size: 14,
                color: AppColors.iconPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}