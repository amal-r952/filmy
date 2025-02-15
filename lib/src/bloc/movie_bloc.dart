import 'dart:async';

import 'package:filmy/src/bloc/base_bloc.dart';
import 'package:filmy/src/models/get_movie_list_response_model.dart';
import 'package:filmy/src/models/movie_response_model.dart';
import 'package:filmy/src/models/state.dart';
import 'package:filmy/src/utils/constants.dart';
import 'package:filmy/src/utils/object_factory.dart';
import 'package:filmy/src/utils/validators.dart';

class MovieBloc extends Object with Validators implements BaseBloc {
  /// Stream Controllers
  final StreamController<bool> _loading = StreamController<bool>.broadcast();
  final StreamController<GetMoviesListResponseModel> _getMovies =
      StreamController<GetMoviesListResponseModel>.broadcast();
  final StreamController<MovieResponseModel> _getMovieDetails =
      StreamController<MovieResponseModel>.broadcast();

  /// Streams
  Stream<bool> get loadingListener => _loading.stream;
  Stream<GetMoviesListResponseModel> get getMoviesResponse => _getMovies.stream;
  Stream<MovieResponseModel> get getMovieDetailsResponse =>
      _getMovieDetails.stream;

  /// Stream Sinks
  StreamSink<bool> get loadingSink => _loading.sink;
  StreamSink<GetMoviesListResponseModel> get getMoviesSink => _getMovies.sink;
  StreamSink<MovieResponseModel> get getMovieDetailsSink =>
      _getMovieDetails.sink;

  /// Functions

  getMovies({required int pageNumber}) async {
    State? state =
        await ObjectFactory().repository.getMovies(pageNumber: pageNumber);

    if (state is SuccessState) {
      getMoviesSink.add(state.value);
    } else if (state is ErrorState) {
      getMoviesSink.addError(Constants.SOME_ERROR_OCCURRED);
    }
  }

  getMovieDetails({required int movieId}) async {
    State? state =
        await ObjectFactory().repository.getMovieDetails(movieId: movieId);

    if (state is SuccessState) {
      getMovieDetailsSink.add(state.value);
    } else if (state is ErrorState) {
      getMovieDetailsSink.addError(Constants.SOME_ERROR_OCCURRED);
    }
  }

  ///disposing the stream if it is not using
  @override
  void dispose() {
    _loading.close();
    _getMovies.close();
  }
}
