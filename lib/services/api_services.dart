import 'package:dio/dio.dart';
import 'package:tmdb_app/config/constant/app_config.dart';
import 'package:tmdb_app/core/presentation/models/movie_model.dart';
import 'package:tmdb_app/features/detail/models/credits_model.dart';
import 'package:tmdb_app/features/detail/models/movie_detail_model.dart';

import 'package:tmdb_app/features/explore/models/genre_model.dart';

class ApiServices {
  static final ApiServices _instance = ApiServices._internal(); 
  factory ApiServices() => _instance;
  ApiServices._internal(); 
  
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl, 
      connectTimeout: const Duration(seconds: 10), 
      receiveTimeout: const Duration(seconds: 10), 
      queryParameters: {
        'api_key' : AppConfig.apiKey 
      }
    )
  );

  // Get Popular Movie 
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response  = await _dio.get('/movie/popular'); 
      final movieResponse = MovieResponse.fromJson(response.data);

      return movieResponse.movies; 
    } on DioException catch (e) {
      throw Exception(_handleErorr(e)); 
    } 
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        '/search/movie', 
        queryParameters: {'query' : query}
      ); 
      final movieResponse = MovieResponse.fromJson(response.data); 
      
      return movieResponse.movies; 
    }on DioException catch(e) {
      throw Exception(_handleErorr(e)); 
    }
  }

  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await _dio.get('/genre/movie/list'); 
      final List genres = response.data['genres']; 

      return genres.map((e) => GenreModel.fromJson(e)).toList(); 
    }on DioException catch(e) {
      throw Exception(_handleErorr(e));
    }
  }

  Future<CreditsResponse> getMovieCredits(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/credits'); 
      final creditsResponse = CreditsResponse.fromJson(response.data); 

      return creditsResponse;  
    } on DioException catch(e) {
      throw Exception(_handleErorr(e)); 
    }
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try{
      final response = await _dio.get('/movie/$movieId'); 
      final detailResponse = MovieDetailModel.fromJson(response.data); 

      return detailResponse; 
    } on DioException catch(e) {
      throw Exception(_handleErorr(e)); 
    }
  }

  String _handleErorr(DioException e) {
    return e.message ?? 'Terjadi Kesalahan'; 
  }
}