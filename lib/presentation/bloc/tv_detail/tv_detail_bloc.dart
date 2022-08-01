import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/is_tv_watchlisted.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final IsTVWatchListed isTVWatchListed;
  final SaveTVWatchList saveTVWatchlist;
  final RemoveTVWatchList removeTVWatchlist;

  TVDetailBloc(
      {required this.getTVDetail,
      required this.getTVRecommendations,
      required this.isTVWatchListed,
      required this.saveTVWatchlist,
      required this.removeTVWatchlist})
      : super(TVDetailState(
            detail: Resource.loading(),
            isWatchListed: Resource.loading(),
            recommendations: Resource.loading())) {
    on<FetchTVDetailEvent>(_onFetchTVDetail);
    on<FetchIsTVWatchListed>(_onFetchIsWatchListed);
  }

  Future<void> _onFetchTVDetail(
      FetchTVDetailEvent event, Emitter<TVDetailState> emit) async {
    emit(state.copyWith(
        detail: Resource.loading(),
        isWatchListed: Resource.loading(),
        recommendations: Resource.loading()));

    await Future.wait([
      _fetchDetail(event.id, emit),
      _fetchRecommendations(event.id, emit),
      _onFetchIsWatchListed(FetchIsTVWatchListed(id: event.id), emit)
    ]);
  }

  Future<void> _fetchDetail(int id, Emitter<TVDetailState> emit) async {
    try {
      final detail = await getTVDetail.execute(id);
      detail.fold((err) => emit(state.copyWith(detail: Resource.error(err))),
          (res) => emit(state.copyWith(detail: Resource.success(res))));
    } on Exception catch (err) {
      emit(state.copyWith(detail: Resource.error(err)));
    }
  }

  Future<void> _fetchRecommendations(
      int id, Emitter<TVDetailState> emit) async {
    try {
      final recommendations = await getTVRecommendations.execute(id);
      recommendations.fold(
          (err) => emit(state.copyWith(recommendations: Resource.error(err))),
          (res) =>
              emit(state.copyWith(recommendations: Resource.success(res))));
    } on Exception catch (err) {
      emit(state.copyWith(recommendations: Resource.error(err)));
    }
  }

  Future<void> _onFetchIsWatchListed(FetchIsTVWatchListed event, Emitter<TVDetailState> emit) async {
    try {
      final isWatchListed = await isTVWatchListed.execute(event.id);
      emit(state.copyWith(isWatchListed: Resource.success(isWatchListed)));
    } on Exception catch (err) {
      emit(state.copyWith(recommendations: Resource.error(err)));
    }
  }

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<String> addWatchList(TVDetail tvDetail) async {
    String message = "";
    (await saveTVWatchlist.execute(tvDetail)).fold((err) => message = err.message, (res) => message = res);
    add(FetchIsTVWatchListed(id: tvDetail.id));
    return message;
  }

  Future<String> removeWatchList(TVDetail tvDetail) async {
    String message = "";
    (await removeTVWatchlist.execute(tvDetail)).fold((err) => message = err.message, (res) => message = res);
    add(FetchIsTVWatchListed(id: tvDetail.id));
    return message;
  }
}
