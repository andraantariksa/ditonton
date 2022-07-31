import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class OnTheAirTVsState extends Equatable {
  final Resource<List<TV>> tvs;

  const OnTheAirTVsState({required this.tvs});

  OnTheAirTVsState copyWith({Resource<List<TV>>? tvs}) {
    return OnTheAirTVsState(tvs: tvs ?? this.tvs);
  }

  @override
  List<Object?> get props => [tvs];
}
