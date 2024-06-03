import 'dart:convert';

LegacyModel accountInfoModelFromJson(String str) =>
    LegacyModel.fromJson(json.decode(str));

String userLegacyModelToJson(LegacyModel data) => json.encode(data.toJson());

class LegacyModel {
  String memberId;
  bool userHasAccount;
  String location;
  String work;
  String legacyStory;
  String firstName;
  String secondName;
  String thirdName;
  Family family;
  String gender;
  dynamic dateOfBirth;
  dynamic dateOfDeath;
  String decision;
  int numOfReports;
  int numOfConfirms;
  dynamic photoBase64;

  LegacyModel({
    required this.memberId,
    required this.userHasAccount,
    required this.location,
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
        memberId: json["memberId"],
        userHasAccount: json["userHasAccount"],
        location: json["location"],
        work: json["work"],
        legacyStory: json["legacyStory"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        thirdName: json["thirdName"],
        family: Family.fromJson(json["family"]),
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        dateOfDeath: json["dateOfDeath"],
        decision: json["decision"],
        numOfReports: json["numOfReports"],
        numOfConfirms: json["numOfConfirms"],
        photoBase64: json["photoBase64"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "userHasAccount": userHasAccount,
        "location": location,
        "work": work,
        "legacyStory": legacyStory,
        "firstName": firstName,
        "secondName": secondName,
        "thirdName": thirdName,
        "family": family.toJson(),
        "gender": gender,
        "dateOfBirth": dateOfBirth,
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
