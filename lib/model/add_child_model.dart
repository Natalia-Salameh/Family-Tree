import 'dart:convert';

AddChildModel addChildModelFromJson(String str) =>
    AddChildModel.fromJson(json.decode(str));

String addChildModelToJson(AddChildModel data) => json.encode(data.toJson());

class AddChildModel {
  String marriageId;
  String childId;

  AddChildModel({
    required this.marriageId,
    required this.childId,
  });

  factory AddChildModel.fromJson(Map<String, dynamic> json) => AddChildModel(
        marriageId: json["MarriageId"],
        childId: json["ChildId"],
      );

  Map<String, dynamic> toJson() => {
        "MarriageId": marriageId,
        "ChildId": childId,
      };
}
