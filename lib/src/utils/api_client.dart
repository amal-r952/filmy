import 'dart:async';

import 'package:dio/dio.dart';
import 'package:filmy/src/utils/constants.dart';
import 'package:filmy/src/utils/urls.dart';

import 'object_factory.dart';

class ApiClient {
  Future<Response> fetchUsers({required int pageNumber}) {
    return ObjectFactory()
        .appDio
        .get(url: "${Urls.getUsersUrl}page=$pageNumber");
  }

  Future<Response> getMovies({required int pageNumber}) {
    return ObjectFactory().appDio.get(
        url:
            "${Urls.moviesUrl}&page=$pageNumber&api_key=${Constants.TMDB_API_KEY}");
  }

  Future<Response> getMovieDetails({required int movieId}) {
    return ObjectFactory().appDio.get(
        url:
            "${Urls.individualMovieUrl}$movieId?api_key=${Constants.TMDB_API_KEY}");
  }
}
