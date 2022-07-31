import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class PopularMoviesState extends Equatable {
  final Resource<List<Movie>> movies;

  const PopularMoviesState({required this.movies});

  PopularMoviesState copyWith({Resource<List<Movie>>? movies}) {
    return PopularMoviesState(movies: movies ?? this.movies);
  }

  @override
  List<Object?> get props => [movies];
}
