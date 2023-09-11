import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _baseurl = 'api.themoviedb.org';
  String _ApiKey = 'ae52a7652ebd5d910b1f43da81ae7702';
  String _Lenguaje = 'es-ES';

  MoviesProvider() {
    print('inicia provider');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(this._baseurl, '3/discover/movie',
        {'api_key': _ApiKey, 'languaje': _Lenguaje, 'page': '1'});
    final response = await http.get(url);
    print(response.body);
  }
}
