import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:ditonton/presentation/provider/tv_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetTVWatchlist])
void main() {
  late TVWatchlistNotifier provider;
  late MockGetTVWatchlist mockGetWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetTVWatchlist();
    provider = TVWatchlistNotifier(
      getWatchlistTVs: mockGetWatchlistMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change TVs data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => Right([testWatchlistTV]));
    // act
    await provider.fetchWatchlistTVs();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistMovies, [testWatchlistTV]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTVs();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
