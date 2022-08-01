import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_event.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late PopularTVsBloc bloc;
  late MockTVRepository mockRepository;
  late GetPopularTVs getPopularTVs;

  setUp(() {
    mockRepository = MockTVRepository();
    getPopularTVs = GetPopularTVs(mockRepository);
    bloc = PopularTVsBloc(getPopularTVs: getPopularTVs);
  });

  blocTest(
    'emits popular TVs when FetchPopularTVsEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getPopular())
          .thenAnswer((_) async => Right(testTVList));
    },
    act: (PopularTVsBloc bloc) => bloc.add(FetchPopularTVsEvent()),
    expect: () => [
      PopularTVsState(tvs: Resource.loading()),
      PopularTVsState(tvs: Resource.success(testTVList)),
    ],
  );
}
