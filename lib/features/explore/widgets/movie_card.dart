import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_config.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap; 

  const MovieCard({super.key, required this.movie, required this.onTap});

  // Ambil tahun dari releaseDate format "YYYY-MM-DD"
  String get _releaseYear {
    if (movie.releaseDate.length >= 4) {
      return movie.releaseDate.substring(0, 4);
    }
    return '-';
  }

  String get _rating {
    return movie.voteAverage.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final hasPoster = movie.posterPath.isNotEmpty;

    return GestureDetector(
      onTap: onTap, 
      child : ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Poster Image ───────────────────────────────────────
            if (hasPoster)
              Image.network(
                '${AppConfig.imageBaseUrl}/w500${movie.posterPath}',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: AppColors.surfaceSecondary,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceSecondary,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.iconSecondary,
                    size: 36,
                  ),
                ),
              )
            else
              Container(
                color: AppColors.surfaceSecondary,
                child: const Icon(
                  Icons.movie_outlined,
                  color: AppColors.iconSecondary,
                  size: 36,
                ),
              ),

            // ── Gradient Overlay ───────────────────────────────────
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.45, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.primaryDark,
                  ],
                ),
              ),
            ),

            // ── Rating Badge (Top Right) ───────────────────────────
            Positioned(
              top: AppDimens.paddingSmall,
              right: AppDimens.paddingSmall,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingSmall,
                  vertical: AppDimens.paddingXsmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withAlpha(200),
                  borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
                  border: Border.all(
                    color: AppColors.primary.withAlpha(80),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.primary,
                      size: 10,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      _rating,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Info Bottom ────────────────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(AppDimens.paddingSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppDimens.fontSizeXs,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Release Year + Vote Count
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.textSecondary,
                          size: 9,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _releaseYear,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}