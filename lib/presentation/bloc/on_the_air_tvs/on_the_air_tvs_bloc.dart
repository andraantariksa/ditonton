import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tvs/on_the_air_tvs_event.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tvs/on_the_air_tvs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirTVsBloc extends Bloc<OnTheAirTVsEvent, OnTheAirTVsState> {
  final GetOnTheAirTVs getOnTheAirTVs;

  OnTheAirTVsBloc({required this.getOnTheAirTVs})
      : super(OnTheAirTVsState(tvs: Resource.loading())) {
    on<FetchOnTheAirTVsEvent>(_onFetchOnTheAirTVs);
  }

  Future<void> _onFetchOnTheAirTVs(
      FetchOnTheAirTVsEvent event, Emitter<OnTheAirTVsState> emit) async {
    emit(state.copyWith(tvs: Resource.loading()));

    (await getOnTheAirTVs.execute()).fold(
        (err) => emit(state.copyWith(tvs: Resource.error(err))),
        (tvs) => emit(state.copyWith(tvs: Resource.success(tvs))));
  }
}
