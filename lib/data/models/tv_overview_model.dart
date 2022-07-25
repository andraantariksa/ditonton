import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TVOverviewModel extends Equatable {
  TVOverviewModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  factory TVOverviewModel.fromJson(Map<String, dynamic> json) => TVOverviewModel(
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    name: json["name"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TV toEntity() {
    return TV(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      firstAirDate: this.releaseDate,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
    backdropPath,
    genreIds,
    id,
    originalName,
    overview,
    popularity,
    posterPath,
    releaseDate,
    name,
    voteAverage,
    voteCount,
  ];
}
