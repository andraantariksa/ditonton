import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMovieDetailEvent extends MovieDetailEvent {
  final int id;

  FetchMovieDetailEvent({ required this.id });
}

class FetchIsMovieWatchListed extends MovieDetailEvent {
  final int id;

  FetchIsMovieWatchListed({ required this.id });
}
