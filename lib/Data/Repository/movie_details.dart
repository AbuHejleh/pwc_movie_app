import 'package:pwc_movie/Data/Models/movie_detail.dart';
import 'package:pwc_movie/Data/Services/movies.dart';

class MoviesDetailsRepository {
  late MoviesServices moviesServices;
  MoviesDetailsRepository(this.moviesServices);

  Future<MovieDetailsModel> getMoviesDetials({required String id}) async {
    var responce = await moviesServices.getMovieDetails(
      movieId: id,
    );
    return MovieDetailsModel.fromJson(responce);
  }
}
