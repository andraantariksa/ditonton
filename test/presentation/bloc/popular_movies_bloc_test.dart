import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late PopularMoviesBloc bloc;
  late MockMovieRepository mockRepository;
  late GetPopularMovies getPopularMovies;

  setUp(() {
    mockRepository = MockMovieRepository();
    getPopularMovies = GetPopularMovies(mockRepository);
    bloc = PopularMoviesBloc(getPopularMovies: getPopularMovies);
  });

  blocTest(
    'emits popular movies when FetchPopularMoviesEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getPopular())
          .thenAnswer((_) async => Right(testMovieList));
    },
    act: (PopularMoviesBloc bloc) => bloc.add(FetchPopularMoviesEvent()),
    expect: () => [
      PopularMoviesState(movies: Resource.loading()),
      PopularMoviesState(movies: Resource.success(testMovieList)),
    ],
  );
}
