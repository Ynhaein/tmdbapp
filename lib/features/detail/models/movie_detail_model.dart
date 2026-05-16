class MovieDetailModel {
  final int id;
  final String title;
  final String overview;
  final String backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final int runtime;
  final String tagline;
  final String status; 
  final List<Genre> genres; 

  const MovieDetailModel({
    required this.id, 
    required this.title, 
    required this.overview, 
    required this.backdropPath, 
    required this.voteAverage, 
    required this.voteCount, 
    required this.releaseDate, 
    required this.runtime, 
    required this.tagline,
    required this.status,
    required this.genres
  });  

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'] ?? 0, 
      title: json['title'] ?? '', 
      overview: json['overview'] ?? '',  
      backdropPath: json['backdrop_path'] ?? '', 
      voteAverage: (json['vote_average'] as num).toDouble(),  
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? '', 
      runtime: json['runtime'] ?? 0, 
      tagline: json['tagline'] ?? '',
      status: json['status'] ?? '',
      genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList()
    );
  }

  String get releaseYear {
    if (releaseDate.length >= 4) return releaseDate.substring(0, 4);
    return '-';
  }

  String get formattedDuration {
    if (runtime == 0) return '-';

    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }
} 

class Genre {
  final int id;
  final String name; 

  const Genre({required this.id, required this.name}); 

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'] ?? 0, name: json['name'] ?? ''); 
  }
}