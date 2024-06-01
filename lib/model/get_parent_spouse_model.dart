// To parse this JSON data, do
//
//     final getParentAndSiblingModel = getParentAndSiblingModelFromJson(jsonString);

import 'dart:convert';

// GetParentAndSiblingModel getParentAndSiblingModelFromJson(String str) =>
//     GetParentAndSiblingModel.fromJson(json.decode(str));

String getParentAndSiblingModelToJson(GetParentAndSiblingModel data) =>
    json.encode(data.toJson());


List<GetParentAndSiblingModel> getParentAndSiblingModelFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    if (jsonData is List) {
      return jsonData.map((item) => GetParentAndSiblingModel.fromJson(item)).toList();
    } else if (jsonData is Map<String, dynamic>) {
      return [GetParentAndSiblingModel.fromJson(jsonData)];
    } else {
      return []; // Return an empty list if JSON format is unexpected
    }
  } on FormatException catch (e) {
    // Log the error or handle it appropriately
    print('Error parsing JSON: $e');
    return []; // Return an empty list or handle as needed when JSON is invalid
  }
}



class GetParentAndSiblingModel {
  String marriageId;
  String marriageStatus;
  Parent1 parent1;
  Parent1 parent2;
  List<Parent1> siblings;

  GetParentAndSiblingModel({
    required this.marriageId,
    required this.marriageStatus,
    required this.parent1,
    required this.parent2,
    required this.siblings,
  });

  factory GetParentAndSiblingModel.fromJson(Map<String, dynamic> json) =>
      GetParentAndSiblingModel(
        marriageId: json["marriageId"],
        marriageStatus: json["marriageStatus"],
        parent1: Parent1.fromJson(json["parent1"]),
        parent2: Parent1.fromJson(json["parent2"]),
        siblings: List<Parent1>.from(
            json["siblings"].map((x) => Parent1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marriageId": marriageId,
        "marriageStatus": marriageStatus,
        "parent1": parent1.toJson(),
        "parent2": parent2.toJson(),
        "siblings": List<dynamic>.from(siblings.map((x) => x.toJson())),
      };
}

class Parent1 {
  String memberId;
  String firstName;
  String secondName;
  String thirdName;
  String familyName;
  String decision;
  String gender;
  dynamic memberPhoto;
  String? parentsChildId;

  Parent1({
    required this.memberId,
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.familyName,
    required this.decision,
    required this.gender,
    required this.memberPhoto,
    this.parentsChildId,
  });

  factory Parent1.fromJson(Map<String, dynamic> json) => Parent1(
        memberId: json["memberId"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        thirdName: json["thirdName"],
        familyName: json["familyName"],
        decision: json["decision"],
        gender: json["gender"],
        memberPhoto: json["memberPhoto"],
        parentsChildId: json["parentsChildId"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "firstName": firstName,
        "secondName": secondName,
        "thirdName": thirdName,
        "familyName": familyName,
        "decision": decision,
        "gender": gender,
        "memberPhoto": memberPhoto,
        "parentsChildId": parentsChildId,
      };
}
