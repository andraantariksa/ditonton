import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieWatchListState extends Equatable {
  final Resource<List<Movie>> movies;

  const MovieWatchListState({required this.movies});

  MovieWatchListState copyWith({Resource<List<Movie>>? movies}) {
    return MovieWatchListState(movies: movies ?? this.movies);
  }

  @override
  List<Object?> get props => [movies];
}
