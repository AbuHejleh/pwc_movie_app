part of 'movie_details_cubit.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class OnComplete extends MovieDetailsState {
  MovieDetailsModel movies;
  OnComplete(this.movies);
}

class Loading extends MovieDetailsState {}
