import 'package:ditonton/data/models/tv_overview_model.dart';
import 'package:equatable/equatable.dart';

class TVsOverviewModel extends Equatable {
  final List<TVOverviewModel> tvList;

  TVsOverviewModel({required this.tvList});

  factory TVsOverviewModel.fromJson(Map<String, dynamic> json) => TVsOverviewModel(
    tvList: List<TVOverviewModel>.from((json["results"] as List)
        .map((x) => TVOverviewModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvList];
}
