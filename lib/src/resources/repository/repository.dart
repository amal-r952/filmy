import 'package:filmy/src/models/state.dart';
import 'package:filmy/src/resources/api_providers/movies_api_provider.dart';
import 'package:filmy/src/resources/api_providers/user_api_provider.dart';

/// Repository is an intermediary class between network and data
class Repository {
  final userApiProvider = UserApiProvider();
  final moviesApiProvider = MoviesApiProvider();

  Future<State?> fetchUsers({required int pageNumber}) =>
      userApiProvider.fetchUsers(pageNumber: pageNumber);
  Future<State?> getMovies({required int pageNumber}) =>
      moviesApiProvider.getMovies(pageNumber: pageNumber);
  Future<State?> getMovieDetails({required int movieId}) =>
      moviesApiProvider.getMovieDetails(movieId: movieId);
}
