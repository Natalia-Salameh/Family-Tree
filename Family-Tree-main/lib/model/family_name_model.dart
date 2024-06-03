import 'dart:convert';

List<FamilyNameModel> familyNameModelFromJson(String str) =>
    List<FamilyNameModel>.from(
        json.decode(str).map((x) => FamilyNameModel.fromJson(x)));

String familyNameModelToJson(List<FamilyNameModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FamilyNameModel {
  String id;
  String failyName;

  FamilyNameModel({
    required this.id,
    required this.failyName,
  });

  factory FamilyNameModel.fromJson(Map<String, dynamic> json) =>
      FamilyNameModel(
        id: json["id"],
        failyName: json["failyName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "failyName": failyName,
      };
}
