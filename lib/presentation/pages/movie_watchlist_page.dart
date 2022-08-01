import 'package:ditonton/common/resource.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieWatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<MovieWatchlistPage>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    BlocProvider.of<MovieWatchListBloc>(context)
        .add(FetchMovieWatchListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieWatchListBloc, MovieWatchListState>(
          builder: (context, state) {
            if (state.movies.state == ResourceState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.movies.state == ResourceState.Success) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies.data![index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.data!.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(state.movies.error.toString()),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
