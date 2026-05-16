class CastModel {
  final int id; 
  final String name; 
  final String profilePath; 
  final String character;  

  const CastModel({required this.id, required this.name, required this.profilePath, required this.character}); 

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0, 
      name: json['name'] ?? '', 
      profilePath: json['profile_path'] ?? '', 
      character: json['character'] ?? ''
    ); 
  }  
}

class CrewModel {
  final int id; 
  final String name; 
  final String job; 

  const CrewModel({required this.id, required this.name, required this.job});  

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      id: json['id'] ?? 0, 
      name: json['name'] ?? '', 
      job: json['job'] ?? ''
    );
  }  
}

class CreditsResponse {
  final List<CastModel> cast; 
  final List<CrewModel> crew;

  const CreditsResponse({required this.cast, required this.crew}); 

  factory CreditsResponse.fromJson(Map<String, dynamic> json) {
    return CreditsResponse(
      cast: (json['cast'] as List).map((e) => CastModel.fromJson(e)).toList(), 
      crew: (json['crew'] as List).map((e) => CrewModel.fromJson(e)).toList()
    );
  } 
}