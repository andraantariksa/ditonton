import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetMovieWatchList {
  final MovieRepository _repository;

  GetMovieWatchList(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlist();
  }
}
