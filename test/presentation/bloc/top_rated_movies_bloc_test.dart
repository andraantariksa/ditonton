import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedMoviesBloc bloc;
  late MockMovieRepository mockRepository;
  late GetTopRatedMovies getTopRatedMovies;

  setUp(() {
    mockRepository = MockMovieRepository();
    getTopRatedMovies = GetTopRatedMovies(mockRepository);
    bloc = TopRatedMoviesBloc(getTopRatedMovies: getTopRatedMovies);
  });

  blocTest(
    'emits top rated movies when FetchTopRatedMoviesEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getTopRated())
          .thenAnswer((_) async => Right(testMovieList));
    },
    act: (TopRatedMoviesBloc bloc) => bloc.add(FetchTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMoviesState(movies: Resource.loading()),
      TopRatedMoviesState(movies: Resource.success(testMovieList)),
    ],
  );
}
