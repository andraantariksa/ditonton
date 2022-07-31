import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs/top_rated_tvs_event.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs/top_rated_tvs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTVsBloc
    extends Bloc<TopRatedTVsEvent, TopRatedTVsState> {
  final GetTopRatedTVs getTopRatedTVs;

  TopRatedTVsBloc({required this.getTopRatedTVs})
      : super(TopRatedTVsState(tvs: Resource.loading())) {
    on<FetchTopRatedTVsEvent>(_onFetchPopularTVs);
  }

  Future<void> _onFetchPopularTVs(
      TopRatedTVsEvent event, Emitter<TopRatedTVsState> emit) async {
    emit(state.copyWith(tvs: Resource.loading()));

    (await getTopRatedTVs.execute()).fold(
        (err) => emit(state.copyWith(tvs: Resource.error(err))),
        (tvs) => emit(state.copyWith(tvs: Resource.success(tvs))));
  }
}
