import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_config.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/features/detail/models/movie_detail_model.dart';
import 'package:tmdb_app/features/detail/widgets/detail_stat_chip.dart';

class DetailHeader extends StatelessWidget {
  final MovieDetailModel movie;
  final VoidCallback onWatchTapped;
  final VoidCallback onBookmarkTapped;

  const DetailHeader({
    super.key,
    required this.movie,
    required this.onWatchTapped,
    required this.onBookmarkTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Backdrop Image ──────────────────────────────────────
        SizedBox(
          height: 480,
          width: double.infinity,
          child: Image.network(
            '${AppConfig.imageBaseUrl}/w780${movie.backdropPath}',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: AppColors.surfaceSecondary,
              child: const Icon(
                Icons.broken_image_outlined,
                color: AppColors.iconSecondary,
                size: 48,
              ),
            ),
          ),
        ),

        // ── Gradient Overlay ────────────────────────────────────
        Container(
          height: 480,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3, 0.7, 1.0],
              colors: [
                AppColors.primaryDark,
                Colors.transparent,
                Colors.transparent,
                AppColors.backgroundPrimary,
              ],
            ),
          ),
        ),

        // ── Back Button ─────────────────────────────────────────
        Positioned(
          top: AppDimens.paddingMedium,
          left: AppDimens.paddingSmall,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryDark.withAlpha(140),
            ),
          ),
        ),


        Positioned(
          bottom: AppDimens.paddingMedium,
          left: AppDimens.paddingMedium,
          right: AppDimens.paddingMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Badge
              if (movie.status.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: AppDimens.gapSmall),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingSmall,
                    vertical: AppDimens.paddingXsmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(220),
                    borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
                  ),
                  child: Text(
                    movie.status.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: AppDimens.fontSizeXs,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),

              // Title
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppDimens.fontSize2xl,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),

              // Tagline
              if (movie.tagline.isNotEmpty) ...[
                const SizedBox(height: AppDimens.gapXsmall),
                Text(
                  '"${movie.tagline}"',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppDimens.fontSizeSmall,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],

              const SizedBox(height: AppDimens.gapSmall),

              // Stat Chips
              Wrap(
                spacing: AppDimens.gapSmall,
                runSpacing: AppDimens.gapSmall,
                children: [
                  DetailStatChip(
                    icon: Icons.star_rounded,
                    label:
                        '${movie.voteAverage.toStringAsFixed(1)} (${_formatVoteCount(movie.voteCount)})',
                    highlight: true,
                  ),
                  DetailStatChip(
                    icon: Icons.calendar_today_outlined,
                    label: movie.releaseYear,
                  ),
                  DetailStatChip(
                    icon: Icons.schedule_rounded,
                    label: movie.formattedDuration,
                  ),
                ],
              ),

              const SizedBox(height: AppDimens.gapSmall),

              // Genre Badges
              if (movie.genres.isNotEmpty)
                Wrap(
                  spacing: AppDimens.gapXsmall,
                  runSpacing: AppDimens.gapXsmall,
                  children: movie.genres
                      .map((g) => _GenreBadge(name: g.name))
                      .toList(),
                ),

              const SizedBox(height: AppDimens.gapMedium),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onWatchTapped,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primaryDark,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.paddingSmall,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimens.radiusMedium,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                        size: AppDimens.iconMedium,
                      ),
                      label: const Text(
                        'WATCH TRAILER',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: AppDimens.fontSizeSmall,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppDimens.gapSmall),

                  // Bookmark Button
                  IconButton(
                    onPressed: onBookmarkTapped,
                    style: IconButton.styleFrom(
                      backgroundColor:
                          AppColors.surfaceSecondary.withAlpha(150),
                      side: const BorderSide(
                        color: AppColors.divider,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusMedium,
                        ),
                      ),
                      padding: const EdgeInsets.all(AppDimens.paddingSmall),
                    ),
                    icon: const Icon(
                      Icons.bookmark_add_outlined,
                      color: AppColors.textPrimary,
                      size: AppDimens.iconMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatVoteCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
    return '$count';
  }
}

// ─── Private Widget ───────────────────────────────────────────────

class _GenreBadge extends StatelessWidget {
  final String name;

  const _GenreBadge({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingSmall,
        vertical: AppDimens.paddingXsmall,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimens.radiusExtraLarge),
        border: Border.all(color: AppColors.outline, width: 0.8),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: AppDimens.fontSizeXs,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}