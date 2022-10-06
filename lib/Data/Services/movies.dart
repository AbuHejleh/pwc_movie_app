import 'package:pwc_movie/Constants/strings.dart';
import 'package:pwc_movie/Data/Services/api_services.dart';

class MoviesServices {
  APIServices _services = APIServices();

  Future<dynamic> getMoviesList(
      {required String title, required num pageNumber}) async {
    var moviesList = await _services.get(
        subUrl: "/?s=$title&apikey=$apiKey&page=$pageNumber");
    return moviesList;
  }

  Future<dynamic> getMovieDetails({required String movieId}) async {
    var moviesDetails =
        await _services.get(subUrl: "/?i=$movieId&apikey=$apiKey");
    return moviesDetails;
  }
}
