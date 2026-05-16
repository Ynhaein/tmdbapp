import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_config.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/features/detail/models/credits_model.dart';

class CastSection extends StatelessWidget {
  final List<CastModel> cast;
  static const int _castLimit = 10;

  const CastSection({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    final displayCast = cast.take(_castLimit).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            const Text(
              'Cast',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppDimens.fontSizeLarge,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: AppDimens.gapXsmall),
            Text(
              '(${displayCast.length})',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppDimens.fontSizeSmall,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppDimens.gapMedium),

        // Cast List
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: displayCast.length,
            separatorBuilder: (_, _) =>
                const SizedBox(width: AppDimens.gapSmall),
            itemBuilder: (context, index) {
              return _CastItem(cast: displayCast[index]);
            },
          ),
        ),
      ],
    );
  }
}

// ─── Private Widget ───────────────────────────────────────────────

class _CastItem extends StatelessWidget {
  final CastModel cast;

  const _CastItem({required this.cast});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = cast.profilePath.isNotEmpty;

    return SizedBox(
      width: 72,
      child: Column(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.divider,
                width: 1,
              ),
              color: AppColors.surfaceSecondary,
            ),
            child: ClipOval(
              child: hasPhoto
                  ? Image.network(
                      '${AppConfig.imageBaseUrl}/w200${cast.profilePath}',
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.person_rounded,
                        color: AppColors.iconSecondary,
                        size: AppDimens.iconMedium,
                      ),
                    )
                  : const Icon(
                      Icons.person_rounded,
                      color: AppColors.iconSecondary,
                      size: AppDimens.iconMedium,
                    ),
            ),
          ),

          const SizedBox(height: AppDimens.gapXsmall),

          // Name
          Text(
            cast.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 2),

          // Character
          Text(
            cast.character,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}