import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist.dart';
import 'package:ditonton/presentation/provider/movie_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetMovieWatchList])
void main() {
  late MovieWatchlistNotifier provider;
  late MockGetMovieWatchlist mockGetWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetMovieWatchlist();
    provider = MovieWatchlistNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => Right([testWatchlistMovie]));
    // act
    await provider.fetchWatchlistMovies();
    // assert
    expect(provider.watchlistState, RequestState.Success);
    expect(provider.watchlistMovies, [testWatchlistMovie]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistMovies();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
