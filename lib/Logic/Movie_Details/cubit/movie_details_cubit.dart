import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pwc_movie/Data/Models/movie_detail.dart';
import 'package:pwc_movie/Data/Repository/movie_details.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MoviesDetailsRepository moviesDetailsRepository;
  MovieDetailsCubit(this.moviesDetailsRepository)
      : super(MovieDetailsInitial());

  MovieDetailsModel? model;

  MovieDetailsModel? getMovieDetials({required String id}) {
    emit(Loading());
    moviesDetailsRepository.getMoviesDetials(id: id).then((moviesList) {
      model = moviesList;
      emit(OnComplete(model!));
    });
    return model;
  }
}
