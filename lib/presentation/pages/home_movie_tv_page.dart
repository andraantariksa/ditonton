import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/movie_search/movie_search_page.dart';
import 'package:ditonton/presentation/pages/movie_watchlist/movie_watchlist_page.dart';
import 'package:ditonton/presentation/pages/tv_search/tv_search_page.dart';
import 'package:ditonton/presentation/pages/tv_watchlist/tv_watchlist_page.dart';
import 'package:ditonton/presentation/widgets/plain_page_route.dart';
import 'package:flutter/material.dart';

class HomeMovieTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/home/';

  final String pageRoute;

  const HomeMovieTVPage({super.key, required this.pageRoute});

  @override
  _HomeMovieTVPageState createState() => _HomeMovieTVPageState();
}

class _HomeMovieTVPageState extends State<HomeMovieTVPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Ditonton'),
                accountEmail: Text('ditonton@dicoding.com'),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Movies'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      '${HomeMovieTVPage.ROUTE_NAME}movie', (route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.save_alt),
                title: Text('Movies Watchlist'),
                onTap: () {
                  Navigator.pushNamed(context, MovieWatchlistPage.ROUTE_NAME);
                },
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('TV'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      '${HomeMovieTVPage.ROUTE_NAME}tv', (route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.save_alt),
                title: Text('TVs Watchlist'),
                onTap: () {
                  Navigator.pushNamed(context, TVWatchlistPage.ROUTE_NAME);
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
                },
                leading: Icon(Icons.info_outline),
                title: Text('About'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Ditonton'),
          actions: [
            IconButton(
              onPressed: () {
                switch (widget.pageRoute) {
                  case HomeMoviePage.ROUTE_NAME:
                    Navigator.pushNamed(context, MovieSearchPage.ROUTE_NAME);
                    break;
                  case HomeTVPage.ROUTE_NAME:
                    Navigator.pushNamed(context, TVSearchPage.ROUTE_NAME);
                    break;
                  default:
                    return null;
                }
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.pageRoute,
          onGenerateRoute: _onGenerateRoute,
        ));
  }

  PlainPageRoute? _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case HomeMoviePage.ROUTE_NAME:
        page = HomeMoviePage();
        break;
      case HomeTVPage.ROUTE_NAME:
        page = HomeTVPage();
        break;
      default:
        return null;
    }

    return PlainPageRoute(builder: (_) => page);
  }
}
