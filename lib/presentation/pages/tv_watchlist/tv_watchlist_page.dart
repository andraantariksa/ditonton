import 'package:ditonton/common/resource.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:ditonton/presentation/pages/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/tv_watchlist/tv_watchlist_event.dart';
import 'package:ditonton/presentation/pages/tv_watchlist/tv_watchlist_state.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TVWatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<TVWatchlistPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return BlocProvider(
        create: (_) => TVWatchListBloc(getTVWatchlist: getIt<GetTVWatchlist>())
          ..add(FetchTVWatchListEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('TV Watchlist'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<TVWatchListBloc, TVWatchListState>(
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
