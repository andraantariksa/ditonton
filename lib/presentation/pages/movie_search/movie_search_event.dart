import 'package:equatable/equatable.dart';

abstract class MovieSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMovieEvent extends MovieSearchEvent {
  final String query;

  SearchMovieEvent({ required this.query });
}
