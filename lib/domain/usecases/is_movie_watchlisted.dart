import 'package:ditonton/domain/repositories/movie_repository.dart';

class IsMovieWatchListed {
  final MovieRepository repository;

  IsMovieWatchListed(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
