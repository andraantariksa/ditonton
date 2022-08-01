import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/is_tv_watchlisted.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVDetailBloc bloc;
  late MockTVRepository mockRepository;
  late RemoveTVWatchList removeTVWatchList;
  late IsTVWatchListed isTVWatchListed;
  late GetTVRecommendations getTVRecommendations;
  late GetTVDetail getTVDetail;
  late SaveTVWatchList saveTVWatchList;

  setUp(() {
    mockRepository = MockTVRepository();
    removeTVWatchList = RemoveTVWatchList(mockRepository);
    isTVWatchListed = IsTVWatchListed(mockRepository);
    getTVRecommendations = GetTVRecommendations(mockRepository);
    getTVDetail = GetTVDetail(mockRepository);
    saveTVWatchList = SaveTVWatchList(mockRepository);
    bloc = TVDetailBloc(
        removeTVWatchList: removeTVWatchList,
        isTVWatchListed: isTVWatchListed,
        getTVRecommendations: getTVRecommendations,
        getTVDetail: getTVDetail,
        saveTVWatchList: saveTVWatchList);
  });

  blocTest(
    'emits tv detail when FetchTVDetailEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getDetail(0))
          .thenAnswer((_) async => Right(testTVDetail));
      when(mockRepository.getRecommendations(0))
          .thenAnswer((_) async => Right(testTVList));
      when(mockRepository.isAddedToWatchlist(0)).thenAnswer((_) async => true);
    },
    act: (TVDetailBloc bloc) => bloc.add(FetchTVDetailEvent(id: 0)),
    expect: () => [
      TVDetailState(
          detail: Resource.loading(),
          recommendations: Resource.loading(),
          isWatchListed: Resource.loading()),
      isA<TVDetailState>(),
      isA<TVDetailState>(),
      TVDetailState(
          detail: Resource.success(testTVDetail),
          isWatchListed: Resource.success(true),
          recommendations: Resource.success(testTVList)),
    ],
  );
}
