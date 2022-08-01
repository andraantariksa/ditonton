import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/is_movie_watchlisted.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final IsMovieWatchListed isMovieWatchListed;
  final SaveMovieWatchList saveMovieWatchlist;
  final RemoveMovieWatchList removeMovieWatchlist;

  MovieDetailBloc(
      {required this.getMovieDetail,
      required this.getMovieRecommendations,
      required this.isMovieWatchListed,
      required this.saveMovieWatchlist,
      required this.removeMovieWatchlist})
      : super(MovieDetailState(
            detail: Resource.loading(),
            isWatchListed: Resource.loading(),
            recommendations: Resource.loading())) {
    on<FetchMovieDetailEvent>(_onFetchMovieDetail);
    on<FetchIsMovieWatchListed>(_onIsWatchListed);
  }

  Future<void> _onFetchMovieDetail(
      FetchMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(state.copyWith(
        detail: Resource.loading(),
        isWatchListed: Resource.loading(),
        recommendations: Resource.loading()));

    await Future.wait([
      _fetchDetail(event.id, emit),
      _fetchRecommendations(event.id, emit),
      _onIsWatchListed(FetchIsMovieWatchListed(id: event.id), emit)
    ]);
  }

  Future<void> _fetchDetail(int id, Emitter<MovieDetailState> emit) async {
    try {
      final detail = await getMovieDetail.execute(id);
      detail.fold((err) => emit(state.copyWith(detail: Resource.error(err))),
          (res) => emit(state.copyWith(detail: Resource.success(res))));
    } on Exception catch (err) {
      emit(state.copyWith(detail: Resource.error(err)));
    }
  }

  Future<void> _fetchRecommendations(
      int id, Emitter<MovieDetailState> emit) async {
    try {
      final recommendations = await getMovieRecommendations.execute(id);
      recommendations.fold(
          (err) => emit(state.copyWith(recommendations: Resource.error(err))),
          (res) =>
              emit(state.copyWith(recommendations: Resource.success(res))));
    } on Exception catch (err) {
      emit(state.copyWith(recommendations: Resource.error(err)));
    }
  }

  Future<void> _onIsWatchListed(
      FetchIsMovieWatchListed event, Emitter<MovieDetailState> emit) async {
    try {
      final isWatchListed = await isMovieWatchListed.execute(event.id);
      emit(state.copyWith(isWatchListed: Resource.success(isWatchListed)));
    } on Exception catch (err) {
      emit(state.copyWith(recommendations: Resource.error(err)));
    }
  }

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<String> addWatchList(MovieDetail movieDetail) async {
    String message = "";
    (await saveMovieWatchlist.execute(movieDetail)).fold((err) => message = err.message, (res) => message = res);
    add(FetchIsMovieWatchListed(id: movieDetail.id));
    return message;
  }

  Future<String> removeWatchList(MovieDetail movieDetail) async {
    String message = "";
    (await removeMovieWatchlist.execute(movieDetail)).fold((err) => message = err.message, (res) => message = res);
    add(FetchIsMovieWatchListed(id: movieDetail.id));
    return message;
  }
}
