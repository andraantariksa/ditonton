import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_tv_page.dart';
import 'package:ditonton/presentation/pages/movie_detail/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie_search/movie_search_page.dart';
import 'package:ditonton/presentation/pages/movie_watchlist/movie_watchlist_page.dart';
import 'package:ditonton/presentation/pages/popular_movies/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv_detail/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_search/tv_search_page.dart';
import 'package:ditonton/presentation/pages/tv_watchlist/tv_watchlist_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseAnalytics.instance;
  await di.init();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ditonton',
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      initialRoute: HomeMovieTVPage.ROUTE_NAME + 'movie',
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name?.startsWith(HomeMovieTVPage.ROUTE_NAME) ?? false) {
          final pageSubRoute =
              settings.name!.substring(HomeMovieTVPage.ROUTE_NAME.length);
          return MaterialPageRoute(
              builder: (_) => HomeMovieTVPage(pageRoute: pageSubRoute));
        }
        switch (settings.name) {
          case PopularMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
          case TopRatedMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
          case PopularTVsPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => PopularTVsPage());
          case TopRatedTVsPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TopRatedTVsPage());
          case MovieDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => MovieDetailPage(id: id),
              settings: settings,
            );
          case TVDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => TVDetailPage(id: id),
              settings: settings,
            );
          case MovieSearchPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => MovieSearchPage());
          case TVSearchPage.ROUTE_NAME:
            return CupertinoPageRoute(builder: (_) => TVSearchPage());
          case MovieWatchlistPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => MovieWatchlistPage());
          case TVWatchlistPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => TVWatchlistPage());
          case AboutPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => AboutPage());
          default:
            return MaterialPageRoute(builder: (_) {
              return Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            });
        }
      },
    );
  }
}
