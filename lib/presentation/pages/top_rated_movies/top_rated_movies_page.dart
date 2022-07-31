import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/pages/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies/top_rated_movies_event.dart';
import 'package:ditonton/presentation/pages/top_rated_movies/top_rated_movies_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movies';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return BlocProvider(
        create: (_) => TopRatedMoviesBloc(getTopRatedMovies: getIt<GetTopRatedMovies>())..add(FetchTopRatedMoviesEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Top Rated Movies'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
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
