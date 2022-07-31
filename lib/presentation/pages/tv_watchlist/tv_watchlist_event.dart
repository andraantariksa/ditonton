import 'package:equatable/equatable.dart';

abstract class TVWatchListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTVWatchListEvent extends TVWatchListEvent {
  FetchTVWatchListEvent();
}
