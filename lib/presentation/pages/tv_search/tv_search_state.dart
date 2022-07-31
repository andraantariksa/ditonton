import 'package:ditonton/common/resource.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TVSearchState extends Equatable {
  final Resource<List<TV>> result;

  const TVSearchState({required this.result});

  TVSearchState copyWith({Resource<List<TV>>? result}) {
    return TVSearchState(result: result ?? this.result);
  }

  @override
  List<Object?> get props => [result];
}
