import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieSearchState extends Equatable {
  final Resource<List<Movie>> result;

  const MovieSearchState({required this.result});

  MovieSearchState copyWith({Resource<List<Movie>>? result}) {
    return MovieSearchState(result: result ?? this.result);
  }

  @override
  List<Object?> get props => [result];
}
