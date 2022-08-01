import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieWatchListBloc
    extends Bloc<MovieWatchListEvent, MovieWatchListState> {
  final GetMovieWatchList getMovieWatchlist;

  MovieWatchListBloc({required this.getMovieWatchlist})
      : super(MovieWatchListState(movies: Resource.loading())) {
    on<FetchMovieWatchListEvent>(_onFetchMovieWatchList);
  }

  Future<void> _onFetchMovieWatchList(
      FetchMovieWatchListEvent event, Emitter<MovieWatchListState> emit) async {
    emit(state.copyWith(movies: Resource.loading()));
    (await getMovieWatchlist.execute()).fold(
        (err) => emit(state.copyWith(movies: Resource.error(err))),
        (res) => emit(state.copyWith(movies: Resource.success(res))));
  }
}
