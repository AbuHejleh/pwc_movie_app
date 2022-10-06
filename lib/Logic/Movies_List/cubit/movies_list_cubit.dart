import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:pwc_movie/Data/Models/movies_list.dart';
import 'package:pwc_movie/Data/Repository/movies_list_repository.dart';

part 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  MoviesListRepository moviesListRepository;
  MoviesListCubit(this.moviesListRepository) : super(MoviesListInitial());
  MovieListModel? model;
  int page = 1;
  TextEditingController textEditingController = TextEditingController();

  MovieListModel? getData({required String title, required num pageNumber}) {
    emit(MoviesListInitial());
    moviesListRepository
        .getMoviesList(title: title, pageNumber: pageNumber)
        .then((moviesList) {
      if (model != null) {
        model!.search.addAll(moviesList.search);
        emit(OnComplete(model!));
        page++;
        print("page no + $page");
      } else {
        model = moviesList;
        emit(OnComplete(model!));
        page++;
      }
    });
    return model;
  }

  MovieListModel? searchForMovie(
      {required String title, required num pageNumber}) {
    emit(MoviesListInitial());
    page = 1;
    moviesListRepository
        .getMoviesList(title: title, pageNumber: pageNumber)
        .then((moviesList) {
      model = moviesList;
      emit(OnComplete(model!));
    });
    return model;
  }
}
