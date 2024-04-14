import 'dart:convert';

List<HomePageModel> homePageModelFromJson(String str) =>
    List<HomePageModel>.from(
        json.decode(str).map((x) => HomePageModel.fromJson(x)));

String homePageModelToJson(List<HomePageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePageModel {
  String id;
  String fullName;
  Gender gender;
  dynamic memberPhoto;

  HomePageModel({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.memberPhoto,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        id: json["id"],
        fullName: json["fullName"],
        gender: genderValues.map[json["gender"]]!,
        memberPhoto: json["memberPhoto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "gender": genderValues.reverse[gender],
        "memberPhoto": memberPhoto,
      };
}

enum Gender { FEMALE, MALE, UNKNOWN }

final genderValues = EnumValues(
    {"Female": Gender.FEMALE, "Male": Gender.MALE, "Unknown": Gender.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
