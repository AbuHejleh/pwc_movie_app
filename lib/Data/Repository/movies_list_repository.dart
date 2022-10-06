import 'package:pwc_movie/Data/Models/movies_list.dart';
import 'package:pwc_movie/Data/Services/movies.dart';

class MoviesListRepository {
  late MoviesServices moviesServices;
  MoviesListRepository(this.moviesServices);

  Future<MovieListModel> getMoviesList(
      {required String title, required num pageNumber}) async {
    var responce = await moviesServices.getMoviesList(
        title: title, pageNumber: pageNumber);
    if (responce["Response"] == "False") {
      return MovieListModel(search: [], totalResults: "0", response: "Failed");
    }
    return MovieListModel.fromJson(responce);
  }
}
