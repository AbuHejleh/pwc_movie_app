import 'dart:convert';

import 'package:pwc_movie/Constants/Enums.dart';

MovieListModel movieModelFromJson(String str) =>
    MovieListModel.fromJson(json.decode(str));

class MovieListModel {
  MovieListModel({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  final List<Movie> search;
  final String totalResults;
  final String response;

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        search: List<Movie>.from(json["Search"].map((x) => Movie.fromJson(x))),
        totalResults: json["totalResults"],
        response: json["Response"],
      );
}

class Movie {
  Movie({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  final String title;
  final String year;
  final String imdbId;
  final MovieType? type;
  final String poster;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        type: typeValues.map[json["Type"]],
        poster: json["Poster"],
      );
}

final typeValues =
    EnumValues({"movie": MovieType.MOVIE, "series": MovieType.SERIES});

class EnumValues<MovieType> {
  Map<String, MovieType> map;
  EnumValues(this.map);
}
