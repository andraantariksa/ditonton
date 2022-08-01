import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  final Resource<MovieDetail> detail;
  final Resource<bool> isWatchListed;
  final Resource<List<Movie>> recommendations;

  const MovieDetailState(
      {required this.detail,
      required this.isWatchListed,
      required this.recommendations});

  MovieDetailState copyWith(
      {Resource<MovieDetail>? detail,
      Resource<bool>? isWatchListed,
      Resource<List<Movie>>? recommendations}) {
    return MovieDetailState(
        detail: detail ?? this.detail,
        isWatchListed: isWatchListed ?? this.isWatchListed,
        recommendations: recommendations ?? this.recommendations);
  }

  @override
  List<Object?> get props => [detail, isWatchListed, recommendations];
}
