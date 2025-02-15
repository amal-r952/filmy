import 'package:filmy/src/models/get_movie_response_model.dart';

class GetMoviesListResponseModel {
  int? page;
  List<GetMovieResponseModel>? results;
  int? totalPages;
  int? totalResults;

  GetMoviesListResponseModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory GetMoviesListResponseModel.fromJson(Map<String, dynamic> json) =>
      GetMoviesListResponseModel(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<GetMovieResponseModel>.from(
                json["results"]!.map((x) => GetMovieResponseModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
