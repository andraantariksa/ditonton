import 'package:ditonton/data/models/movie_overview_model.dart';
import 'package:equatable/equatable.dart';

class MoviesOverviewModel extends Equatable {
  final List<MovieOverviewModel> movieList;

  MoviesOverviewModel({required this.movieList});

  factory MoviesOverviewModel.fromJson(Map<String, dynamic> json) => MoviesOverviewModel(
        movieList: List<MovieOverviewModel>.from((json["results"] as List)
            .map((x) => MovieOverviewModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
