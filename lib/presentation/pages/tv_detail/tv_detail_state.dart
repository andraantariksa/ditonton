import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVDetailState extends Equatable {
  final Resource<TVDetail> detail;
  final Resource<bool> isWatchListed;
  final Resource<List<TV>> recommendations;

  const TVDetailState(
      {required this.detail,
      required this.isWatchListed,
      required this.recommendations});

  TVDetailState copyWith(
      {Resource<TVDetail>? detail,
      Resource<bool>? isWatchListed,
      Resource<List<TV>>? recommendations}) {
    return TVDetailState(
        detail: detail ?? this.detail,
        isWatchListed: isWatchListed ?? this.isWatchListed,
        recommendations: recommendations ?? this.recommendations);
  }

  @override
  List<Object?> get props => [detail, isWatchListed, recommendations];
}
