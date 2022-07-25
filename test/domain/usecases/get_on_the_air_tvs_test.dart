import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTVs usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetOnTheAirTVs(mockTVRepository);
  });

  final tTVs = <TV>[];

  test('should get list of on the air TVs from the repository', () async {
    // arrange
    when(mockTVRepository.getOnTheAir())
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVs));
  });
}
