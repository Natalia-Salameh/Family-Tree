import 'dart:convert';

LegacyModel accountInfoModelFromJson(String str) =>
    LegacyModel.fromJson(json.decode(str));

String accountInfoModelToJson(LegacyModel data) => json.encode(data.toJson());

class LegacyModel {
  bool userHasAccount;
  String education;
  String work;
  String legacyStory;
  String firstName;
  String secondName;
  String thirdName;
  Family family;
  String gender;
  DateTime dateOfBirth;
  dynamic dateOfDeath;
  String decision;
  int numOfReports;
  int numOfConfirms;
  dynamic photoBase64;

  LegacyModel({
    required this.userHasAccount,
    required this.education,
    required this.work,
    required this.legacyStory,
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.family,
    required this.gender,
    required this.dateOfBirth,
    required this.dateOfDeath,
    required this.decision,
    required this.numOfReports,
    required this.numOfConfirms,
    required this.photoBase64,
  });

  factory LegacyModel.fromJson(Map<String, dynamic> json) => LegacyModel(
        userHasAccount: json["userHasAccount"],
        education: json["education"],
        work: json["work"],
        legacyStory: json["legacyStory"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        thirdName: json["thirdName"],
        family: Family.fromJson(json["family"]),
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        dateOfDeath: json["dateOfDeath"],
        decision: json["decision"],
        numOfReports: json["numOfReports"],
        numOfConfirms: json["numOfConfirms"],
        photoBase64: json["photoBase64"],
      );

  Map<String, dynamic> toJson() => {
        "userHasAccount": userHasAccount,
        "education": education,
        "work": work,
        "legacyStory": legacyStory,
        "firstName": firstName,
        "secondName": secondName,
        "thirdName": thirdName,
        "family": family.toJson(),
        "gender": gender,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "dateOfDeath": dateOfDeath,
        "decision": decision,
        "numOfReports": numOfReports,
        "numOfConfirms": numOfConfirms,
        "photoBase64": photoBase64,
      };
}

class Family {
  String id;
  String familyName;

  Family({
    required this.id,
    required this.familyName,
  });

  factory Family.fromJson(Map<String, dynamic> json) => Family(
        id: json["id"],
        familyName: json["familyName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "familyName": familyName,
      };
}
