import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TVWatchListState extends Equatable {
  final Resource<List<TV>> tvs;

  const TVWatchListState({required this.tvs});

  TVWatchListState copyWith({Resource<List<TV>>? result}) {
    return TVWatchListState(tvs: result ?? this.tvs);
  }

  @override
  List<Object?> get props => [tvs];
}
