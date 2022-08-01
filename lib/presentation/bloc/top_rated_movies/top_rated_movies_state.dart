import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class TopRatedMoviesState extends Equatable {
  final Resource<List<Movie>> movies;

  const TopRatedMoviesState({required this.movies});

  TopRatedMoviesState copyWith({Resource<List<Movie>>? movies}) {
    return TopRatedMoviesState(movies: movies ?? this.movies);
  }

  @override
  List<Object?> get props => [movies];
}
