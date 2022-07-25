import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVs usecase;
  late MockTVRepository mockTVRpository;

  setUp(() {
    mockTVRpository = MockTVRepository();
    usecase = GetPopularTVs(mockTVRpository);
  });

  final tTVs = <TV>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of popular TVs from the repository',
          () async {
        // arrange
        when(mockTVRpository.getPopular())
            .thenAnswer((_) async => Right(tTVs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTVs));
      });
    });
  });
}
