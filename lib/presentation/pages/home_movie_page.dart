import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movie_event.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = 'movie';

  @override
  State<StatefulWidget> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => getIt<NowPlayingMoviesBloc>()
                ..add(FetchNowPlayingMoviesEvent())),
          BlocProvider(
              create: (_) =>
                  getIt<PopularMoviesBloc>()..add(FetchPopularMoviesEvent())),
          BlocProvider(
              create: (_) =>
                  getIt<TopRatedMoviesBloc>()..add(FetchTopRatedMoviesEvent())),
        ],
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Now Playing',
                    style: kHeading6,
                  ),
                  BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                      builder: (context, state) {
                    if (state.movies.state == ResourceState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.movies.state == ResourceState.Success) {
                      return MovieList(state.movies.data!);
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed(PopularMoviesPage.ROUTE_NAME),
                  ),
                  BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                      builder: (context, state) {
                    if (state.movies.state == ResourceState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.movies.state == ResourceState.Success) {
                      return MovieList(state.movies.data!);
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed(TopRatedMoviesPage.ROUTE_NAME),
                  ),
                  BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                      builder: (context, state) {
                    if (state.movies.state == ResourceState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.movies.state == ResourceState.Success) {
                      return MovieList(state.movies.data!);
                    } else {
                      return Text('Failed');
                    }
                  }),
                ],
              ),
            ),
          ),
        ));
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
