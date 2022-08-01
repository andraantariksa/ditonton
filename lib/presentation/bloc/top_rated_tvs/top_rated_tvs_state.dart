import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TopRatedTVsState extends Equatable {
  final Resource<List<TV>> tvs;

  const TopRatedTVsState({required this.tvs});

  TopRatedTVsState copyWith({Resource<List<TV>>? tvs}) {
    return TopRatedTVsState(tvs: tvs ?? this.tvs);
  }

  @override
  List<Object?> get props => [tvs];
}
