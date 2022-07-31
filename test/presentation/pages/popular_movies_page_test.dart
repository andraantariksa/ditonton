// ignore_for_file: unused_element
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/provider/movies_popular_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([MoviesPopularNotifier])
void main() {
  late MockMoviesPopularNotifier mockNotifier;

  setUp(() {
    di.init();
    mockNotifier = MockMoviesPopularNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MoviesPopularNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  // testWidgets('Page should display center progress bar when loading',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Loading);
  //
  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   final centerFinder = find.byType(Center);
  //
  //   await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
  //
  //   expect(centerFinder, findsOneWidget);
  //   expect(progressBarFinder, findsOneWidget);
  // });
  //
  // testWidgets('Page should display ListView when data is loaded',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Success);
  //   when(mockNotifier.movies).thenReturn(<Movie>[]);
  //
  //   final listViewFinder = find.byType(ListView);
  //
  //   await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
  //
  //   expect(listViewFinder, findsOneWidget);
  // });
  //
  // testWidgets('Page should display text with message when Error',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Error);
  //   when(mockNotifier.message).thenReturn('Error message');
  //
  //   final textFinder = find.byKey(Key('error_message'));
  //
  //   await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
  //
  //   expect(textFinder, findsOneWidget);
  // });
}
