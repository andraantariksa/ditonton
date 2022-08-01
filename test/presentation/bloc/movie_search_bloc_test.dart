import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieSearchBloc bloc;
  late MockMovieRepository mockRepository;
  late SearchMovies searchMovies;

  setUp(() {
    mockRepository = MockMovieRepository();
    searchMovies = SearchMovies(mockRepository);
    bloc = MovieSearchBloc(searchMovies: searchMovies);
  });

  blocTest(
    'emits searched movie when SearchMovieEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.search("some query"))
          .thenAnswer((_) async => Right(testMovieList));
    },
    act: (MovieSearchBloc bloc) =>
        bloc.add(SearchMovieEvent(query: "some query")),
    expect: () => [
      MovieSearchState(result: Resource.loading()),
      MovieSearchState(result: Resource.success(testMovieList)),
    ],
  );
}
