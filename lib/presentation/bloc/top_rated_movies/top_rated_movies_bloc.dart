import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesState(movies: Resource.loading())) {
    on<FetchTopRatedMoviesEvent>(_onFetchPopularMovies);
  }

  Future<void> _onFetchPopularMovies(
      FetchTopRatedMoviesEvent event, Emitter<TopRatedMoviesState> emit) async {
    emit(state.copyWith(movies: Resource.loading()));

    (await getTopRatedMovies.execute()).fold(
        (err) => emit(state.copyWith(movies: Resource.error(err))),
        (tvs) => emit(state.copyWith(movies: Resource.success(tvs))));
  }
}
