import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/models/movie_model.dart';
import 'package:tmdb_app/features/explore/models/genre_model.dart';
import 'package:tmdb_app/features/explore/widgets/genre_filter_button.dart';
import 'package:tmdb_app/features/explore/widgets/movie_card.dart';
import 'package:tmdb_app/features/explore/widgets/search_input.dart';
import 'package:tmdb_app/services/api_services.dart';
import 'package:tmdb_app/features/detail/page/movie_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ApiServices _apiServices = ApiServices();

  String _searchQuery = '';
  int _selectedGenreId = 0;

  List<GenreModel> _genres = [];
  bool _isLoadingGenres = true;

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    try {
      final fetched = await _apiServices.getGenres();
      if (mounted) {
        setState(() {
          _genres = [const GenreModel(id: 0, name: 'All'), ...fetched];
          _isLoadingGenres = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingGenres = false);
    }
  }

  Future<List<MovieModel>> get _moviesFuture {
    return _searchQuery.isEmpty
        ? _apiServices.getPopularMovies()
        : _apiServices.searchMovies(_searchQuery);
  }

  List<MovieModel> _applyGenreFilter(List<MovieModel> movies) {
    if (_selectedGenreId == 0) return movies;
    return movies
        .where((m) => m.genreIds.contains(_selectedGenreId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Search Input ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.paddingMedium,
              AppDimens.paddingMedium,
              AppDimens.paddingMedium,
              0,
            ),
            child: SearchInput(
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          const SizedBox(height: AppDimens.gapMedium),

          // ── Genre Filter ───────────────────────────────────────
          if (_isLoadingGenres)
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.paddingMedium,
              ),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.surfaceSecondary,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(
                left: AppDimens.paddingMedium,
              ),
              child: GenreFilterButton(
                selectedGenreId: _selectedGenreId,
                genres: _genres,
                onGenreSelected: (id) =>
                    setState(() => _selectedGenreId = id),
              ),
            ),

          const SizedBox(height: AppDimens.gapMedium),

          // ── Movie Grid ─────────────────────────────────────────
          Expanded(
            child: FutureBuilder<List<MovieModel>>(
              future: _moviesFuture,
              builder: (context, snapshot) {
                // Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Error
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
                        const Text(
                          'Failed to load the movie',
                          style: TextStyle(
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

                final movies = _applyGenreFilter(snapshot.data ?? []);

                // Empty
                if (movies.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          color: AppColors.iconSecondary,
                          size: 48,
                        ),
                        const SizedBox(height: AppDimens.gapMedium),
                        Text(
                          _searchQuery.isEmpty
                              ? 'Movie not found'
                              : 'No results for "$_searchQuery"',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppDimens.fontSizeBase,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // ── Grid ─────────────────────────────────────────
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.paddingMedium,
                    0,
                    AppDimens.paddingMedium,
                    AppDimens.paddingXLarge * 2,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.62,
                        crossAxisSpacing: AppDimens.gapSmall,
                        mainAxisSpacing: AppDimens.gapSmall,
                      ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: movies[index], 
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_) => MovieDetailPage(movie: movies[index])
                          )
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}