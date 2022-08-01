import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieWatchListBloc bloc;
  late MockMovieRepository mockRepository;
  late GetMovieWatchList getMovieWatchlist;

  setUp(() {
    mockRepository = MockMovieRepository();
    getMovieWatchlist = GetMovieWatchList(mockRepository);
    bloc = MovieWatchListBloc(getMovieWatchlist: getMovieWatchlist);
  });

  blocTest(
    'emits movie watchlist when FetchMovieWatchListEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getWatchlist())
          .thenAnswer((_) async => Right(testMovieList));
    },
    act: (MovieWatchListBloc bloc) => bloc.add(FetchMovieWatchListEvent()),
    expect: () => [
      MovieWatchListState(movies: Resource.loading()),
      MovieWatchListState(movies: Resource.success(testMovieList)),
    ],
  );
}
