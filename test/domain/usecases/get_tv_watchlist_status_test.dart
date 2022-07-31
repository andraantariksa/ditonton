import 'package:ditonton/domain/usecases/is_tv_watchlisted.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late IsTVWatchListed usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = IsTVWatchListed(mockTVRepository);
  });

  test('should get TV watchlist status from repository', () async {
    // arrange
    when(mockTVRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
