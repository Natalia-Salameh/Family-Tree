import 'dart:convert';

DiaryModel diaryModelFromJson(String str) =>
    DiaryModel.fromJson(json.decode(str));

String diaryModelToJson(DiaryModel data) => json.encode(data.toJson());

class DiaryModel {
  String location;
  String work;
  String legacyStory;

  DiaryModel({
    required this.location,
    required this.work,
    required this.legacyStory,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) => DiaryModel(
        location: json["Location"],
        work: json["Work"],
        legacyStory: json["LegacyStory"],
      );

  Map<String, dynamic> toJson() => {
        "Location": location,
        "Work": work,
        "LegacyStory": legacyStory,
      };
}
