import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
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
                  Navigator.pushNamedAndRemoveUntil(context, '${HomeMovieTVPage.ROUTE_NAME}movie', (route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('TV'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '${HomeMovieTVPage.ROUTE_NAME}tv', (route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.save_alt),
                title: Text('Watchlist'),
                onTap: () {
                  Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
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
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
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
