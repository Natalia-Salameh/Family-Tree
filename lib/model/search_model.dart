import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  String? id;
  String fullName;

  SearchModel({
    this.id,
    required this.fullName,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json["id"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
      };
}
