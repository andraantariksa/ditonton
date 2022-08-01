import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movie_event.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingMoviesBloc bloc;
  late MockMovieRepository mockRepository;
  late GetNowPlayingMovies getNowPlayingMovies;

  setUp(() {
    mockRepository = MockMovieRepository();
    getNowPlayingMovies = GetNowPlayingMovies(mockRepository);
    bloc = NowPlayingMoviesBloc(getNowPlayingMovies: getNowPlayingMovies);
  });

  blocTest(
    'emits now playing movies when FetchNowPlayingMoviesEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getNowPlaying())
          .thenAnswer((_) async => Right(testMovieList));
    },
    act: (NowPlayingMoviesBloc bloc) => bloc.add(FetchNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesState(movies: Resource.loading()),
      NowPlayingMoviesState(movies: Resource.success(testMovieList)),
    ],
  );
}
