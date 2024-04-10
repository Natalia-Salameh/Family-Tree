import 'dart:convert';

MemberFormModel memberFormModelFromJson(String str) =>
    MemberFormModel.fromJson(json.decode(str));

String memberFormModelToJson(MemberFormModel data) =>
    json.encode(data.toJson());

class MemberFormModel {
  String firstName;
  String secondName;
  String thirdName;
  String familyId;
  String gender;
  DateTime dateOfBirth;
  DateTime dateOfDeath;

  MemberFormModel({
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.familyId,
    required this.gender,
    required this.dateOfBirth,
    required this.dateOfDeath,
  });

  factory MemberFormModel.fromJson(Map<String, dynamic> json) =>
      MemberFormModel(
        firstName: json["FirstName"],
        secondName: json["SecondName"],
        thirdName: json["ThirdName"],
        familyId: json["FamilyId"],
        gender: json["Gender"],
        dateOfBirth: DateTime.parse(json["DateOfBirth"]),
        dateOfDeath: json["DateOfDeath"],
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "SecondName": secondName,
        "ThirdName": thirdName,
        "FamilyId": familyId,
        "Gender": gender,
        "DateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "DateOfDeath": dateOfDeath,
      };
}
