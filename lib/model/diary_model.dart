import 'dart:convert';

DiaryModel diaryModelFromJson(String str) =>
    DiaryModel.fromJson(json.decode(str));

String diaryModelToJson(DiaryModel data) => json.encode(data.toJson());

class DiaryModel {
  String education;
  String work;
  String legacyStory;

  DiaryModel({
    required this.education,
    required this.work,
    required this.legacyStory,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) => DiaryModel(
        education: json["Education"],
        work: json["Work"],
        legacyStory: json["LegacyStory"],
      );

  Map<String, dynamic> toJson() => {
        "Education": education,
        "Work": work,
        "LegacyStory": legacyStory,
      };
}
