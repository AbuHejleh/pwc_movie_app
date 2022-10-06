import 'package:bloc/bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:pwc_movie/Constants/strings.dart';

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
    moviesListRepository
        .getMoviesList(title: title, pageNumber: pageNumber)
        .then((moviesList) {
      if (model != null) {
        emit(MoviesListInitial());
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
    int page = 1;
    emit(MoviesListInitial());
    moviesListRepository
        .getMoviesList(title: title, pageNumber: pageNumber)
        .then((moviesList) {
      model = moviesList;
      emit(OnComplete(model!));
      page++;
    });
    return model;
  }

  void initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deeplink = dynamicLink!.link;

      if (deeplink != null) {
        List<String> sepeatedLink = [];

        sepeatedLink.addAll(deeplink.path.split('/'));

        print("The Token that i'm interesed in is ${sepeatedLink[1]}");
         Navigator.of(context).pushNamed(
                                  movieDetailsScreen,
                                  arguments: sepeatedLink[1]);

       
      }
    }, onError: (OnLinkErrorException e) async {
      print("We got error $e");
    });
  }
}
