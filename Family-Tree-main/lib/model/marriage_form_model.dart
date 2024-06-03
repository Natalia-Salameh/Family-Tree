import 'dart:convert';

AddMarriageModel addMarriageModelFromJson(String str) =>
    AddMarriageModel.fromJson(json.decode(str));

String addMarriageModelToJson(AddMarriageModel data) =>
    json.encode(data.toJson());

class AddMarriageModel {
  String partner1Id;
  String partner2Id;
  String marriageStatus;
  DateTime dateOfMarriage;

  AddMarriageModel({
    required this.partner1Id,
    required this.partner2Id,
    required this.marriageStatus,
    required this.dateOfMarriage,
  });

  factory AddMarriageModel.fromJson(Map<String, dynamic> json) =>
      AddMarriageModel(
        partner1Id: json["Partner1Id"],
        partner2Id: json["Partner2Id"],
        marriageStatus: json["MarriageStatus"],
        dateOfMarriage: DateTime.parse(json["DateOfMarriage"]),
      );

  Map<String, dynamic> toJson() => {
        "Partner1Id": partner1Id,
        "Partner2Id": partner2Id,
        "MarriageStatus": marriageStatus,
        "DateOfMarriage":
            "${dateOfMarriage.year.toString().padLeft(4, '0')}-${dateOfMarriage.month.toString().padLeft(2, '0')}-${dateOfMarriage.day.toString().padLeft(2, '0')}",
      };
}
