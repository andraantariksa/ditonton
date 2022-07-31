import 'package:equatable/equatable.dart';

enum ResourceState { Loading, Error, Success, Idle }

class Resource<T> extends Equatable {
  final T? data;
  final Exception? error;
  final ResourceState state;

  const Resource({this.data, this.error, this.state = ResourceState.Loading});

  factory Resource.loading() {
    return Resource();
  }

  factory Resource.idle() {
    return Resource(state: ResourceState.Idle);
  }

  factory Resource.success(T? data) {
    return Resource(data: data, state: ResourceState.Success);
  }

  factory Resource.error(Exception? error) {
    return Resource(error: error, state: ResourceState.Error);
  }

  @override
  List<Object?> get props => [data, error, state];
}
