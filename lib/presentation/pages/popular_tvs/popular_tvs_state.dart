import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class PopularTVsState extends Equatable {
  final Resource<List<TV>> tvs;

  const PopularTVsState({required this.tvs});

  PopularTVsState copyWith({Resource<List<TV>>? tvs}) {
    return PopularTVsState(tvs: tvs ?? this.tvs);
  }

  @override
  List<Object?> get props => [tvs];
}
