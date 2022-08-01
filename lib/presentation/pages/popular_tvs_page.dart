import 'package:ditonton/common/resource.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_event.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_state.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PopularTVsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTVsPageState createState() => _PopularTVsPageState();
}

class _PopularTVsPageState extends State<PopularTVsPage> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return BlocProvider(
        create: (_) => getIt<PopularTVsBloc>()..add(FetchPopularTVsEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Popular TVs'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<PopularTVsBloc, PopularTVsState>(
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
