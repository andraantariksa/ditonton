// ignore_for_file: unused_element
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/provider/movies_top_rated_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([MoviesTopRatedNotifier])
void main() {
  late MockMoviesTopRatedNotifier mockNotifier;

  setUp(() {
    di.init();
    mockNotifier = MockMoviesTopRatedNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MoviesTopRatedNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  // testWidgets('Page should display progress bar when loading',
  //         (WidgetTester tester) async {
  //       when(mockNotifier.state).thenReturn(RequestState.Loading);
  //
  //       final progressFinder = find.byType(CircularProgressIndicator);
  //       final centerFinder = find.byType(Center);
  //
  //       await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
  //
  //       expect(centerFinder, findsOneWidget);
  //       expect(progressFinder, findsOneWidget);
  //     });
  //
  // testWidgets('Page should display when data is loaded',
  //         (WidgetTester tester) async {
  //       when(mockNotifier.state).thenReturn(RequestState.Success);
  //       when(mockNotifier.movies).thenReturn(<Movie>[]);
  //
  //       final listViewFinder = find.byType(ListView);
  //
  //       await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
  //
  //       expect(listViewFinder, findsOneWidget);
  //     });
  //
  // testWidgets('Page should display text with message when Error',
  //         (WidgetTester tester) async {
  //       when(mockNotifier.state).thenReturn(RequestState.Error);
  //       when(mockNotifier.message).thenReturn('Error message');
  //
  //       final textFinder = find.byKey(Key('error_message'));
  //
  //       await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
  //
  //       expect(textFinder, findsOneWidget);
  //     });
}
