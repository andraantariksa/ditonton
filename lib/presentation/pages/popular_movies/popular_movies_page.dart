import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/pages/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies/popular_movies_event.dart';
import 'package:ditonton/presentation/pages/popular_movies/popular_movies_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movies';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return BlocProvider(
        create: (_) => PopularMoviesBloc(getPopularMovies: getIt<GetPopularMovies>())..add(FetchPopularMoviesEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Popular Movies'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
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
        ));
  }
}
