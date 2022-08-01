import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSearchBloc bloc;
  late MockTVRepository mockRepository;
  late SearchTVs searchTVs;

  setUp(() {
    mockRepository = MockTVRepository();
    searchTVs = SearchTVs(mockRepository);
    bloc = TVSearchBloc(searchTVs: searchTVs);
  });

  blocTest(
    'emits searched tvs when SearchTVEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.search("some query"))
          .thenAnswer((_) async => Right(testTVList));
    },
    act: (TVSearchBloc bloc) => bloc.add(SearchTVEvent(query: "some query")),
    expect: () => [
      TVSearchState(result: Resource.loading()),
      TVSearchState(result: Resource.success(testTVList)),
    ],
  );
}
