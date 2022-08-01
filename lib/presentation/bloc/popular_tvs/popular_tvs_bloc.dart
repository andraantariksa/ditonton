import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_event.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTVsBloc extends Bloc<PopularTVsEvent, PopularTVsState> {
  final GetPopularTVs getPopularTVs;

  PopularTVsBloc({required this.getPopularTVs})
      : super(PopularTVsState(tvs: Resource.loading())) {
    on<FetchPopularTVsEvent>(_onFetchPopularTVs);
  }

  Future<void> _onFetchPopularTVs(
      FetchPopularTVsEvent event, Emitter<PopularTVsState> emit) async {
    emit(state.copyWith(tvs: Resource.loading()));

    (await getPopularTVs.execute()).fold(
        (err) => emit(state.copyWith(tvs: Resource.error(err))),
        (tvs) => emit(state.copyWith(tvs: Resource.success(tvs))));
  }
}
