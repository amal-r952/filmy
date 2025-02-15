import 'dart:convert';

import 'get_user_response_model.dart';

GetUsersListResponseModel getUsersListResponseModelFromJson(String str) =>
    GetUsersListResponseModel.fromJson(json.decode(str));

String getUsersListResponseModelToJson(GetUsersListResponseModel data) =>
    json.encode(data.toJson());

class GetUsersListResponseModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<GetUserResponseModel>? data;
  Support? support;

  GetUsersListResponseModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory GetUsersListResponseModel.fromJson(Map<String, dynamic> json) =>
      GetUsersListResponseModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json["data"] == null
            ? []
            : List<GetUserResponseModel>.from(
                json["data"]!.map((x) => GetUserResponseModel.fromJson(x))),
        support:
            json["support"] == null ? null : Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "support": support?.toJson(),
      };
}

class Support {
  String? url;
  String? text;

  Support({
    this.url,
    this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
