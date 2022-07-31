import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/pages/on_the_air_tvs/on_the_air_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/on_the_air_tvs/on_the_air_tvs_event.dart';
import 'package:ditonton/presentation/pages/on_the_air_tvs/on_the_air_tvs_state.dart';
import 'package:ditonton/presentation/pages/popular_tvs/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tvs/popular_tvs_event.dart';
import 'package:ditonton/presentation/pages/popular_tvs/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs/popular_tvs_state.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs/top_rated_tvs_event.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs/top_rated_tvs_state.dart';
import 'package:ditonton/presentation/pages/tv_detail/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeTVPage extends StatefulWidget {
  static const ROUTE_NAME = 'tv';

  @override
  State<StatefulWidget> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  OnTheAirTVsBloc(getOnTheAirTVs: getIt<GetOnTheAirTVs>())
                    ..add(FetchOnTheAirTVsEvent())),
          BlocProvider(
              create: (_) =>
                  PopularTVsBloc(getPopularTVs: getIt<GetPopularTVs>())
                    ..add(FetchPopularTVsEvent())),
          BlocProvider(
              create: (_) =>
                  TopRatedTVsBloc(getTopRatedTVs: getIt<GetTopRatedTVs>())
                    ..add(FetchTopRatedTVsEvent())),
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
                  BlocBuilder<OnTheAirTVsBloc, OnTheAirTVsState>(
                      builder: (context, state) {
                    if (state.tvs.state == ResourceState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.tvs.state == ResourceState.Success) {
                      return TVList(state.tvs.data!);
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed(PopularTVsPage.ROUTE_NAME),
                  ),
                  BlocBuilder<PopularTVsBloc, PopularTVsState>(
                      builder: (context, state) {
                    if (state.tvs.state == ResourceState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.tvs.state == ResourceState.Success) {
                      return TVList(state.tvs.data!);
                    } else {
                      return Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed(TopRatedTVsPage.ROUTE_NAME),
                  ),
                  BlocBuilder<TopRatedTVsBloc, TopRatedTVsState>(
                      builder: (context, state) {
                    if (state.tvs.state == ResourceState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.tvs.state == ResourceState.Success) {
                      return TVList(state.tvs.data!);
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

class TVList extends StatelessWidget {
  final List<TV> tvs;

  TVList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  TVDetailPage.ROUTE_NAME,
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
        itemCount: tvs.length,
      ),
    );
  }
}
