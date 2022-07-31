import 'package:ditonton/domain/repositories/tv_repository.dart';

class IsTVWatchListed {
  final TVRepository repository;

  IsTVWatchListed(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
