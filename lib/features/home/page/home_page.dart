import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/models/movie_model.dart';
import 'package:tmdb_app/features/home/widgets/movie_slider.dart';
import 'package:tmdb_app/features/home/widgets/trending_item.dart';
import 'package:tmdb_app/services/api_services.dart';
import 'package:tmdb_app/features/detail/page/movie_detail_page.dart';

class HomePage extends StatelessWidget {
  // Callback ke MainNavigation untuk switch ke tab Explore
  final VoidCallback? onSeeAllTapped;

  const HomePage({super.key, this.onSeeAllTapped});

  static const int _trendingLimit = 5;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: ApiServices().getPopularMovies(),
      builder: (context, snapshot) {
        // ── Loading ──────────────────────────────────────────────
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // ── Error ────────────────────────────────────────────────
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off_rounded,
                  color: AppColors.iconSecondary,
                  size: 48,
                ),
                const SizedBox(height: AppDimens.gapMedium),
                Text(
                  'Gagal memuat film',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppDimens.fontSizeLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimens.gapSmall),
                Text(
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppDimens.fontSizeXs,
                  ),
                ),
              ],
            ),
          );
        }

        // ── Empty ────────────────────────────────────────────────
        final movies = snapshot.data ?? [];
        if (movies.isEmpty) {
          return const Center(
            child: Text(
              'Tidak ada film ditemukan',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppDimens.fontSizeLarge,
              ),
            ),
          );
        }

        final trendingMovies = movies.take(_trendingLimit).toList();

        // ── Content ──────────────────────────────────────────────
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: AppDimens.paddingXLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieSlider(movies: movies),

                const SizedBox(height: AppDimens.gapMedium),

                // Trending Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingMedium,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trending',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppDimens.fontSizeXl,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: onSeeAllTapped,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'See All →',
                          style: TextStyle(
                            fontSize: AppDimens.fontSizeSmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimens.gapSmall),
                
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingMedium,
                  ),
                  itemCount: trendingMovies.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppDimens.gapSmall),
                  itemBuilder: (context, index) {
                    return TrendingItem(
                      movie: trendingMovies[index], 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailPage(movie : trendingMovies[index])
                          ) 
                        );
                      },
                      rank: index + 1,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
