import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, List<Movie>>> getTopRated();
  Future<Either<Failure, MovieDetail>> getDetail(int id);
  Future<Either<Failure, List<Movie>>> getRecommendations(int id);
  Future<Either<Failure, List<Movie>>> search(String query);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlist();
}
