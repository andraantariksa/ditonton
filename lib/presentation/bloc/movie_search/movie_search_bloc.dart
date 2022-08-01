import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies})
      : super(MovieSearchState(result: Resource.idle())) {
    on<SearchMovieEvent>(_onSearch);
  }

  Future<void> _onSearch(
      SearchMovieEvent event, Emitter<MovieSearchState> emit) async {
    emit(state.copyWith(result: Resource.loading()));
    (await searchMovies.execute(event.query)).fold(
        (err) => emit(state.copyWith(result: Resource.error(err))),
        (res) => emit(state.copyWith(result: Resource.success(res))));
  }
}
