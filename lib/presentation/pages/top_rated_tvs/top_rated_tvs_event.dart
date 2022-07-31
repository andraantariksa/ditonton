import 'package:equatable/equatable.dart';

abstract class TopRatedTVsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTopRatedTVsEvent extends TopRatedTVsEvent {
  FetchTopRatedTVsEvent();
}
