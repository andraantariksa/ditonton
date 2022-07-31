import 'package:ditonton/domain/usecases/is_movie_watchlisted.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late IsMovieWatchListed usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = IsMovieWatchListed(mockMovieRepository);
  });

  test('should get movie watchlist status from repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
