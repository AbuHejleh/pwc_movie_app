import 'package:bloc/bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:meta/meta.dart';
import 'package:pwc_movie/Data/Models/movie_detail.dart';
import 'package:pwc_movie/Data/Repository/movie_details.dart';
import 'package:share_plus/share_plus.dart';

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

  Future<void> shareLinks(
      {required String title,
      required String image,
      required String docId}) async {
    String url = "https://pwcmovie.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/$docId'),
      androidParameters: AndroidParameters(
        packageName: "com.example.pwc_movie",
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
        bundleId: "Bundle-ID",
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: '', imageUrl: Uri.parse("$image"), title: title),
    );

    final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();

    String? desc = '${dynamicUrl.shortUrl.toString()}';

    await Share.share(
      desc,
      subject: title,
    );
  }
}
