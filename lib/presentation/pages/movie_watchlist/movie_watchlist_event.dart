import 'package:equatable/equatable.dart';

abstract class MovieWatchListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMovieWatchListEvent extends MovieWatchListEvent {
  FetchMovieWatchListEvent();
}
