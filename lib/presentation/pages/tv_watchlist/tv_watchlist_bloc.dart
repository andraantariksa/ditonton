import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:ditonton/presentation/pages/tv_watchlist/tv_watchlist_event.dart';
import 'package:ditonton/presentation/pages/tv_watchlist/tv_watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVWatchListBloc extends Bloc<TVWatchListEvent, TVWatchListState> {
  final GetTVWatchlist getTVWatchlist;

  TVWatchListBloc({required this.getTVWatchlist})
      : super(TVWatchListState(tvs: Resource.loading())) {
    on<FetchTVWatchListEvent>(_onFetchTVWatchList);
  }

  Future<void> _onFetchTVWatchList(
      FetchTVWatchListEvent event, Emitter<TVWatchListState> emit) async {
    emit(state.copyWith(result: Resource.loading()));
    (await getTVWatchlist.execute()).fold(
        (err) => emit(state.copyWith(result: Resource.error(err))),
        (res) => emit(state.copyWith(result: Resource.success(res))));
  }
}
