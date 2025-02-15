import 'dart:convert';

GetUserResponseModel getUserResponseModelFromJson(String str) =>
    GetUserResponseModel.fromJson(json.decode(str));

String getUserResponseModelToJson(GetUserResponseModel data) =>
    json.encode(data.toJson());

class GetUserResponseModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  GetUserResponseModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) =>
      GetUserResponseModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
