import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/pages/popular_movies/popular_movies_event.dart';
import 'package:ditonton/presentation/pages/popular_movies/popular_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesState(movies: Resource.loading())) {
    on<FetchPopularMoviesEvent>(_onFetchPopularMovies);
  }

  Future<void> _onFetchPopularMovies(
      FetchPopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    emit(state.copyWith(movies: Resource.loading()));

    (await getPopularMovies.execute()).fold(
        (err) => emit(state.copyWith(movies: Resource.error(err))),
        (tvs) => emit(state.copyWith(movies: Resource.success(tvs))));
  }
}
