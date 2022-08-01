import 'package:equatable/equatable.dart';

abstract class TVDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTVDetailEvent extends TVDetailEvent {
  final int id;

  FetchTVDetailEvent({ required this.id });
}

class FetchIsTVWatchListed extends TVDetailEvent {
  final int id;

  FetchIsTVWatchListed({ required this.id });
}
