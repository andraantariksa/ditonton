import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class NowPlayingMoviesState extends Equatable {
  final Resource<List<Movie>> movies;

  const NowPlayingMoviesState({required this.movies});

  NowPlayingMoviesState copyWith({Resource<List<Movie>>? movies}) {
    return NowPlayingMoviesState(movies: movies ?? this.movies);
  }

  @override
  List<Object?> get props => [movies];
}
