import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVOverviewTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  TVOverviewTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TVOverviewTable.fromEntity(TVDetail tv) => TVOverviewTable(
    id: tv.id,
    title: tv.title,
    posterPath: tv.posterPath,
    overview: tv.overview,
  );

  factory TVOverviewTable.fromMap(Map<String, dynamic> map) => TVOverviewTable(
    id: map['id'],
    title: map['title'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'posterPath': posterPath,
    'overview': overview,
  };

  TV toEntity() => TV.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: title,
  );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}