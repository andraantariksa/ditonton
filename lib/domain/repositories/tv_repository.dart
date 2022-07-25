import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getNowPlaying();
  Future<Either<Failure, List<TV>>> getPopular();
  Future<Either<Failure, List<TV>>> getTopRated();
  Future<Either<Failure, TVDetail>> getDetail(int id);
  Future<Either<Failure, List<TV>>> getRecommendations(int id);
  Future<Either<Failure, List<TV>>> search(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail movie);
  Future<Either<Failure, String>> removeWatchlist(TVDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlist();
}
