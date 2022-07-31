import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/provider/tvs_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvs_popular_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTVs])
void main() {
  late MockGetPopularTVs mockGetPopularTVs;
  late TVsPopularNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTVs = MockGetPopularTVs();
    notifier = TVsPopularNotifier(mockGetPopularTVs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = TV(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVList = <TV>[tMovie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    notifier.fetchPopularTVs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    await notifier.fetchPopularTVs();
    // assert
    expect(notifier.state, RequestState.Success);
    expect(notifier.tvs, tTVList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTVs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTVs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
