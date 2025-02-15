import 'package:filmy/src/models/get_movie_list_response_model.dart';
import 'package:filmy/src/models/movie_response_model.dart';
import 'package:filmy/src/models/state.dart';
import 'package:filmy/src/utils/object_factory.dart';

class MoviesApiProvider {
  Future<State?> getMovies({required int pageNumber}) async {
    final response =
        await ObjectFactory().apiClient.getMovies(pageNumber: pageNumber);
    // print(response);
    if (response.statusCode == 200) {
      return State<GetMoviesListResponseModel>.success(
          GetMoviesListResponseModel.fromJson(response.data));
    } else {
      return null;
    }
  }

  Future<State?> getMovieDetails({required int movieId}) async {
    final response =
        await ObjectFactory().apiClient.getMovieDetails(movieId: movieId);
    // print(response);
    if (response.statusCode == 200) {
      return State<MovieResponseModel>.success(
          MovieResponseModel.fromJson(response.data));
    } else {
      return null;
    }
  }
}
