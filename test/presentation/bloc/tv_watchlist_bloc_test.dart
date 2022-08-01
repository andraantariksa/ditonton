import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVWatchListBloc bloc;
  late MockTVRepository mockRepository;
  late GetTVWatchList getTVWatchlist;

  setUp(() {
    mockRepository = MockTVRepository();
    getTVWatchlist = GetTVWatchList(mockRepository);
    bloc = TVWatchListBloc(getTVWatchlist: getTVWatchlist);
  });

  blocTest(
    'emits TV watchlist when FetchTVWatchListEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getWatchlist())
          .thenAnswer((_) async => Right(testTVList));
    },
    act: (TVWatchListBloc bloc) => bloc.add(FetchTVWatchListEvent()),
    expect: () => [
      TVWatchListState(tvs: Resource.loading()),
      TVWatchListState(tvs: Resource.success(testTVList)),
    ],
  );
}
