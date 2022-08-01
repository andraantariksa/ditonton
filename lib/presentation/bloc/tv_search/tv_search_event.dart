import 'package:equatable/equatable.dart';

abstract class TVSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchTVEvent extends TVSearchEvent {
  final String query;

  SearchTVEvent({ required this.query });
}
