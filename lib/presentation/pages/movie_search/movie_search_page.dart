import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/pages/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/pages/movie_search/movie_search_event.dart';
import 'package:ditonton/presentation/pages/movie_search/movie_search_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MovieSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-movie';

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;

    return BlocProvider(
        create: (_) => MovieSearchBloc(searchMovies: getIt<SearchMovies>()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Search Movie'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MovieSearchBloc, MovieSearchState>(
                    builder: (context, state) => TextField(
                          onSubmitted: (query) {
                            BlocProvider.of<MovieSearchBloc>(context)
                                .add(SearchMovieEvent(query: query));
                          },
                          decoration: InputDecoration(
                            hintText: 'Search title',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.search,
                        )),
                SizedBox(height: 16),
                Text(
                  'Search Result',
                  style: kHeading6,
                ),
                BlocBuilder<MovieSearchBloc, MovieSearchState>(
                  builder: (context, state) {
                    if (state.result.state == ResourceState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.result.state == ResourceState.Success) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = state.result.data![index];
                            return MovieCard(movie);
                          },
                          itemCount: state.result.data!.length,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
