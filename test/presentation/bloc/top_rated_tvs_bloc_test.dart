import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs/top_rated_tvs_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs/top_rated_tvs_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedTVsBloc bloc;
  late MockTVRepository mockRepository;
  late GetTopRatedTVs getTopRatedTVs;

  setUp(() {
    mockRepository = MockTVRepository();
    getTopRatedTVs = GetTopRatedTVs(mockRepository);
    bloc = TopRatedTVsBloc(getTopRatedTVs: getTopRatedTVs);
  });

  blocTest(
    'emits top rated tvs when FetchTopRatedTVsEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getTopRated())
          .thenAnswer((_) async => Right(testTVList));
    },
    act: (TopRatedTVsBloc bloc) => bloc.add(FetchTopRatedTVsEvent()),
    expect: () => [
      TopRatedTVsState(tvs: Resource.loading()),
      TopRatedTVsState(tvs: Resource.success(testTVList)),
    ],
  );
}
