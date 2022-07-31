import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/pages/now_playing_movies/now_playing_movie_event.dart';
import 'package:ditonton/presentation/pages/now_playing_movies/now_playing_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc({required this.getNowPlayingMovies})
      : super(NowPlayingMoviesState(movies: Resource.loading())) {
    on<FetchNowPlayingMoviesEvent>(_onFetchNowPlayingMovies);
  }

  Future<void> _onFetchNowPlayingMovies(
      FetchNowPlayingMoviesEvent event, Emitter<NowPlayingMoviesState> emit) async {
    emit(state.copyWith(movies: Resource.loading()));

    (await getNowPlayingMovies.execute()).fold(
        (err) => emit(state.copyWith(movies: Resource.error(err))),
        (tvs) => emit(state.copyWith(movies: Resource.success(tvs))));
  }
}
