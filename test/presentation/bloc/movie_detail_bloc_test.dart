import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/is_movie_watchlisted.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailBloc bloc;
  late MockMovieRepository mockRepository;
  late RemoveMovieWatchList removeMovieWatchList;
  late IsMovieWatchListed isMovieWatchListed;
  late GetMovieRecommendations getMovieRecommendations;
  late GetMovieDetail getMovieDetail;
  late SaveMovieWatchList saveMovieWatchList;

  setUp(() {
    mockRepository = MockMovieRepository();
    removeMovieWatchList = RemoveMovieWatchList(mockRepository);
    isMovieWatchListed = IsMovieWatchListed(mockRepository);
    getMovieRecommendations = GetMovieRecommendations(mockRepository);
    getMovieDetail = GetMovieDetail(mockRepository);
    saveMovieWatchList = SaveMovieWatchList(mockRepository);
    bloc = MovieDetailBloc(
        removeMovieWatchlist: removeMovieWatchList,
        isMovieWatchListed: isMovieWatchListed,
        getMovieRecommendations: getMovieRecommendations,
        getMovieDetail: getMovieDetail,
        saveMovieWatchlist: saveMovieWatchList);
  });

  blocTest(
    'emits movie detail when FetchMovieDetailEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getDetail(0))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockRepository.getRecommendations(0))
          .thenAnswer((_) async => Right(testMovieList));
      when(mockRepository.isAddedToWatchlist(0)).thenAnswer((_) async => true);
    },
    act: (MovieDetailBloc bloc) => bloc.add(FetchMovieDetailEvent(id: 0)),
    expect: () => [
      MovieDetailState(
          detail: Resource.loading(),
          recommendations: Resource.loading(),
          isWatchListed: Resource.loading()),
      isA<MovieDetailState>(),
      isA<MovieDetailState>(),
      MovieDetailState(
          detail: Resource.success(testMovieDetail),
          isWatchListed: Resource.success(true),
          recommendations: Resource.success(testMovieList)),
    ],
  );
}
