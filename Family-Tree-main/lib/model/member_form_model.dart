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
  DateTime? dateOfBirth;
 // DateTime? dateOfDeath;
  String? photoBase64;

  MemberFormModel({
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.familyId,
    required this.gender,
    this.dateOfBirth,
  //  this.dateOfDeath,
    this.photoBase64,
  });

  factory MemberFormModel.fromJson(Map<String, dynamic> json) =>
      MemberFormModel(
        firstName: json["FirstName"],
        secondName: json["SecondName"],
        thirdName: json["ThirdName"],
        familyId: json["FamilyId"],
        gender: json["Gender"],
        dateOfBirth: json["DateOfBirth"] == null ? null : DateTime.parse(json["DateOfBirth"]),
     //   dateOfDeath: json["DateOfDeath"] == null ? null : DateTime.parse(json["DateOfDeath"]),
        photoBase64: json["PhotoBase64"],
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "SecondName": secondName,
        "ThirdName": thirdName,
        "FamilyId": familyId,
        "Gender": gender,
        "DateOfBirth": dateOfBirth == null ? null : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
     //   "DateOfDeath": dateOfDeath == null ? null : "${dateOfDeath!.year.toString().padLeft(4, '0')}-${dateOfDeath!.month.toString().padLeft(2, '0')}-${dateOfDeath!.day.toString().padLeft(2, '0')}",
        "PhotoBase64": photoBase64,
      };
}
