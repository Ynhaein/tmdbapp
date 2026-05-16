import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_config.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/models/movie_model.dart';

class TrendingItem extends StatelessWidget {
  final MovieModel movie;
  final int? rank;
  final VoidCallback onTap; 

  const TrendingItem({super.key, required this.movie, required this.rank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingSmall),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          border: Border.all(color: AppColors.divider, width: 0.5),
        ),

        child: Row(
          children: [
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
              child: Image.network(
                '${AppConfig.imageBaseUrl}/w200${movie.posterPath}',
                width: 70,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 70,
                  height: 100,
                  color: AppColors.surfaceSecondary,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.iconSecondary,
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppDimens.gapMedium),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimens.fontSizeBase,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: AppDimens.gapSmall),

                  // Overview
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimens.fontSizeXs,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: AppDimens.gapSmall),

                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.primary,
                        size: AppDimens.iconSmall,
                      ),
                      const SizedBox(width: AppDimens.gapXsmall),
                      Text(
                        '${movie.voteAverage.toStringAsFixed(1)} / 10',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppDimens.fontSizeXs,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}