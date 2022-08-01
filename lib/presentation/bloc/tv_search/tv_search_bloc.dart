import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSearchBloc extends Bloc<TVSearchEvent, TVSearchState> {
  final SearchTVs searchTVs;

  TVSearchBloc({required this.searchTVs})
      : super(TVSearchState(result: Resource.idle())) {
    on<SearchTVEvent>(_onSearch);
  }

  Future<void> _onSearch(
      SearchTVEvent event, Emitter<TVSearchState> emit) async {
    emit(state.copyWith(result: Resource.loading()));
    (await searchTVs.execute(event.query)).fold(
        (err) => emit(state.copyWith(result: Resource.error(err))),
        (res) => emit(state.copyWith(result: Resource.success(res))));
  }
}
