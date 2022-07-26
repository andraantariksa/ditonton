import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTVs, GetPopularTVs, GetTopRatedTVs])
void main() {
  late TVListNotifier provider;
  late MockGetOnTheAirTVs mockGetOnTheAirTVs;
  late MockGetPopularTVs mockGetPopularTVs;
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTVs = MockGetOnTheAirTVs();
    mockGetPopularTVs = MockGetPopularTVs();
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    provider = TVListNotifier(
      getOnTheAirTVs: mockGetOnTheAirTVs,
      getPopularTVs: mockGetPopularTVs,
      getTopRatedTVs: mockGetTopRatedTVs,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTV = TV(
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
  final tTVList = <TV>[tTV];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTVs();
      // assert
      verify(mockGetOnTheAirTVs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTVs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchOnTheAirTVs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingMovies, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTVs();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Loaded);
      expect(provider.popularTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTVs();
      // assert
      expect(provider.popularTVsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Loaded);
      expect(provider.topRatedTVs, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTVs();
      // assert
      expect(provider.topRatedTVsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}