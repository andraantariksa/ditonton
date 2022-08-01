import 'package:ditonton/common/resource.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs/top_rated_tvs_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs/top_rated_tvs_state.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TopRatedTVsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvs';

  @override
  _TopRatedTVsPageState createState() => _TopRatedTVsPageState();
}

class _TopRatedTVsPageState extends State<TopRatedTVsPage> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return BlocProvider(
        create: (_) => getIt<TopRatedTVsBloc>()..add(FetchTopRatedTVsEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Top Rated TVs'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<TopRatedTVsBloc, TopRatedTVsState>(
              builder: (context, state) {
                if (state.tvs.state == ResourceState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.tvs.state == ResourceState.Success) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.tvs.data![index];
                      return TVCard(tv);
                    },
                    itemCount: state.tvs.data!.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.tvs.error.toString()),
                  );
                }
              },
            ),
          ),
        ));
  }
}
