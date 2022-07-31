import 'package:equatable/equatable.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  FetchNowPlayingMoviesEvent();
}
