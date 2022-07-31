import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/pages/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/pages/tv_search/tv_search_event.dart';
import 'package:ditonton/presentation/pages/tv_search/tv_search_state.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TVSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;

    return BlocProvider(
        create: (_) => TVSearchBloc(searchTVs: getIt<SearchTVs>()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Search TV'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<TVSearchBloc, TVSearchState>(
                    builder: (context, state) => TextField(
                          onSubmitted: (query) {
                            BlocProvider.of<TVSearchBloc>(context)
                                .add(SearchTVEvent(query: query));
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
                BlocBuilder<TVSearchBloc, TVSearchState>(
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
                            final tv = state.result.data![index];
                            return TVCard(tv);
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
