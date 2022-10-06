import 'dart:convert';

MovieDetailsModel movieDetailsModelFromJson(String str) =>
    MovieDetailsModel.fromJson(json.decode(str));

class MovieDetailsModel {
  MovieDetailsModel({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    // required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.totalSeasons,
    required this.response,
  });

  final String? title;
  final String? year;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? plot;
  final String? language;
  final String? country;
  final String? awards;
  final String? poster;
  // final List<Rating> ratings;
  final String? metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? imdbId;
  final String? type;
  final String? totalSeasons;
  final String? response;

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailsModel(
        title: json["Title"],
        year: json["Year"],
        rated: json["Rated"],
        released: json["Released"],
        runtime: json["Runtime"],
        genre: json["Genre"],
        director: json["Director"],
        writer: json["Writer"],
        actors: json["Actors"],
        plot: json["Plot"],
        language: json["Language"],
        country: json["Country"],
        awards: json["Awards"],
        poster: json["Poster"],
        // ratings:
        //     List<Rating>.from(json["Ratings"].map((x) => Rating.fromJson(x))),
        metascore: json["Metascore"],
        imdbRating: json["imdbRating"],
        imdbVotes: json["imdbVotes"],
        imdbId: json["imdbID"],
        type: json["Type"],
        totalSeasons: json["totalSeasons"],
        response: json["Response"],
      );
}

class Rating {
  Rating({
    required this.source,
    required this.value,
  });

  final String source;
  final String value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        source: json["Source"],
        value: json["Value"],
      );
}
