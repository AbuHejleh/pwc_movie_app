part of 'movies_list_cubit.dart';

@immutable
abstract class MoviesListState {}

class MoviesListInitial extends MoviesListState {}

class OnComplete extends MoviesListState {
  MovieListModel movies;
  OnComplete(this.movies);


 
}
