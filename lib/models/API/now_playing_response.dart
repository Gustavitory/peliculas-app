import 'dart:convert';

import 'package:movies_app/models/API/movie.dart';

class NowPlayingResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  NowPlayingResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlayingResponse.fromJson(String str) =>
      NowPlayingResponse.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory NowPlayingResponse.fromMap(Map<String, dynamic> json) =>
      NowPlayingResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  // Map<String, dynamic> toMap() => {
  //       "page": page,
  //       "results": List<dynamic>.from(results.map((x) => x.toMap())),
  //       "total_pages": totalPages,
  //       "total_results": totalResults,
  //     };
}
