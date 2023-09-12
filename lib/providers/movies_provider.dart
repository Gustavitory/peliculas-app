import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/API/popular_movies_response.dart';
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseurl = 'api.themoviedb.org';
  final String _apiKey = 'ae52a7652ebd5d910b1f43da81ae7702';
  final String _lenguaje = 'es-ES';

  Future getConstructor(String route, int page) async {
    var url = Uri.https(_baseurl, route,
        {"api_key": _apiKey, "languaje": _lenguaje, "page": "$page"});
    return await http.get(url);
  }

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int popularPage = 1;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future getOnDisplayMovies() async {
    final response = await getConstructor('3/discover/movie', 1);
    final decodedData = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = decodedData.results;
    notifyListeners();
  }

  Future getPopularMovies() async {
    final response = await getConstructor('3/movie/popular', popularPage);
    final decodedData = PopularMoviesResponse.fromJson(response.body);
    popularMovies = [...popularMovies, ...decodedData.results];
    notifyListeners();
  }

  nextPopularPage() async {
    popularPage++;
    return await getPopularMovies();
  }
}
