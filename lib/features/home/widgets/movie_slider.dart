import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_config.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/models/movie_model.dart';

class MovieSlider extends StatefulWidget {
  final List<MovieModel> movies;

  const MovieSlider({super.key, required this.movies});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  late final PageController _pageController;
  late final List<MovieModel> _sliderMovies;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _sliderMovies = widget.movies.take(5).toList();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % _sliderMovies.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Slider
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _sliderMovies.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return _SliderItem(movie: _sliderMovies[index]);
            },
          ),
        ),

        const SizedBox(height: AppDimens.gapMedium),

        // ── Bottom Row: Button ←→ Dots ──────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Watch Trailer Button
              FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.primaryDark,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.paddingSmall,
                    horizontal: AppDimens.paddingLarge,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimens.radiusExtraLarge,
                    ),
                  ),
                ),
                icon: const Icon(Icons.play_arrow_rounded, size: AppDimens.iconMedium),
                label: const Text(
                  'WATCH MOVIE',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimens.fontSizeXs,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Dot Pagination
              Row(
                children: List.generate(
                  _sliderMovies.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(left: AppDimens.gapXsmall),
                    width: _currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.primary
                          : AppColors.iconSecondary,
                      borderRadius: BorderRadius.circular(
                        AppDimens.radiusCircular,
                      ),
                    ),
                  ),
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

class _SliderItem extends StatelessWidget {
  final MovieModel movie;

  const _SliderItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Backdrop Image
        Image.network(
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

        // Gradient Overlay — gelap dari bawah
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.4, 1.0],
              colors: [
                Colors.transparent,
                Colors.transparent,
                AppColors.backgroundPrimary,
              ],
            ),
          ),
        ),

        // Text Info
        Positioned(
          bottom: AppDimens.paddingMedium,
          left: AppDimens.paddingMedium,
          right: AppDimens.paddingMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppDimens.fontSizeXl,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),

              const SizedBox(height: AppDimens.gapXsmall),

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
            ],
          ),
        ),
      ],
    );
  }
}