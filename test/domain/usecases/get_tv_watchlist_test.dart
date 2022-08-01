import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVWatchList usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVWatchList(mockTVRepository);
  });

  test('should get TVs watchlist from the repository', () async {
    // arrange
    when(mockTVRepository.getWatchlist())
        .thenAnswer((_) async => Right(testTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVList));
  });
}
