import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/models/movie_model.dart';
import 'package:tmdb_app/features/detail/models/credits_model.dart';
import 'package:tmdb_app/features/detail/models/movie_detail_model.dart';
import 'package:tmdb_app/features/detail/widgets/cast_section.dart';
import 'package:tmdb_app/features/detail/widgets/crew_section.dart';
import 'package:tmdb_app/features/detail/widgets/detail_header.dart';
import 'package:tmdb_app/features/detail/widgets/detail_synopsis.dart';
import 'package:tmdb_app/services/api_services.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final ApiServices _apiServices = ApiServices();

  late final Future<MovieDetailModel> _detailFuture;
  late final Future<CreditsResponse> _creditsFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = _apiServices.getMovieDetail(widget.movie.id);
    _creditsFuture = _apiServices.getMovieCredits(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieDetailModel>(
        future: _detailFuture,
        builder: (context, snapshot) {
          // ── Loading ────────────────────────────────────────────
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          // ── Error ──────────────────────────────────────────────
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: AppColors.iconSecondary,
                    size: 48,
                  ),
                  const SizedBox(height: AppDimens.gapMedium),
                  const Text(
                    'Gagal memuat detail film',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimens.fontSizeLarge,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppDimens.gapSmall),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            );
          }

          final detail = snapshot.data!;

          // ── Content ────────────────────────────────────────────
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (Backdrop + Overlay Info)
                  DetailHeader(
                    movie: detail,
                    onWatchTapped: () {},
                    onBookmarkTapped: () {},
                  ),

                  // Body Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.paddingMedium,
                      0,
                      AppDimens.paddingMedium,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Synopsis
                        DetailSynopsis(overview: detail.overview),

                        const SizedBox(height: AppDimens.gapLarge),

                        // Cast & Crew
                        FutureBuilder<CreditsResponse>(
                          future: _creditsFuture,
                          builder: (context, creditsSnap) {
                            if (creditsSnap.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(AppDimens.paddingLarge),
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }

                            if (!creditsSnap.hasData) return const SizedBox();

                            final credits = creditsSnap.data!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Cast
                                if (credits.cast.isNotEmpty) ...[
                                  CastSection(cast: credits.cast),
                                  const SizedBox(height: AppDimens.gapLarge),
                                ],

                                // Crew
                                if (credits.crew.isNotEmpty) ...[
                                  CrewSection(crew: credits.crew),
                                  const SizedBox(height: AppDimens.gapLarge),
                                ],
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }
}