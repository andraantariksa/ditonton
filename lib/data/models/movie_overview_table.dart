import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieOverviewTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  MovieOverviewTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory MovieOverviewTable.fromEntity(MovieDetail movie) => MovieOverviewTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieOverviewTable.fromMap(Map<String, dynamic> map) => MovieOverviewTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
