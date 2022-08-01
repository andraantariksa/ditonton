import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tvs/on_the_air_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tvs/on_the_air_tvs_event.dart';
import 'package:ditonton/presentation/bloc/on_the_air_tvs/on_the_air_tvs_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late OnTheAirTVsBloc bloc;
  late MockTVRepository mockRepository;
  late GetOnTheAirTVs getOnTheAirTVs;

  setUp(() {
    mockRepository = MockTVRepository();
    getOnTheAirTVs = GetOnTheAirTVs(mockRepository);
    bloc = OnTheAirTVsBloc(getOnTheAirTVs: getOnTheAirTVs);
  });

  blocTest(
    'emits on the air tvs when FetchOnTheAirTVsEvent is added',
    build: () => bloc,
    setUp: () {
      when(mockRepository.getOnTheAir())
          .thenAnswer((_) async => Right(testTVList));
    },
    act: (OnTheAirTVsBloc bloc) => bloc.add(FetchOnTheAirTVsEvent()),
    expect: () => [
      OnTheAirTVsState(tvs: Resource.loading()),
      OnTheAirTVsState(tvs: Resource.success(testTVList)),
    ],
  );
}
