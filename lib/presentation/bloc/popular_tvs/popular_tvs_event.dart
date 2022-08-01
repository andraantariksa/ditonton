import 'package:equatable/equatable.dart';

abstract class PopularTVsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPopularTVsEvent extends PopularTVsEvent {
  FetchPopularTVsEvent();
}
