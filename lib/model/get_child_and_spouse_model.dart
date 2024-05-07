import 'dart:convert';

List<GetSpouseAndChildrenModel> getSpouseAndChildrenModelFromJson(String str) =>
    List<GetSpouseAndChildrenModel>.from(
        json.decode(str).map((x) => GetSpouseAndChildrenModel.fromJson(x)));

String getSpouseAndChildrenModelToJson(List<GetSpouseAndChildrenModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSpouseAndChildrenModel {
  String marriageId;
  String marriageStatus;
  Spouse spouse;
  List<Spouse> children;

  GetSpouseAndChildrenModel({
    required this.marriageId,
    required this.marriageStatus,
    required this.spouse,
    required this.children,
  });

  factory GetSpouseAndChildrenModel.fromJson(Map<String, dynamic> json) =>
      GetSpouseAndChildrenModel(
        marriageId: json["marriageId"],
        marriageStatus: json["marriageStatus"],
        spouse: Spouse.fromJson(json["spouse"]),
        children:
            List<Spouse>.from(json["children"].map((x) => Spouse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marriageId": marriageId,
        "marriageStatus": marriageStatus,
        "spouse": spouse.toJson(),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class Spouse {
  String memberId;
  String firstName;
  String secondName;
  String thirdName;
  String familyName;
  String decision;
  dynamic memberPhoto;

  Spouse({
    required this.memberId,
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.familyName,
    required this.decision,
    required this.memberPhoto,
  });

  factory Spouse.fromJson(Map<String, dynamic> json) => Spouse(
        memberId: json["memberId"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        thirdName: json["thirdName"],
        familyName: json["familyName"],
        decision: json["decision"],
        memberPhoto: json["memberPhoto"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "firstName": firstName,
        "secondName": secondName,
        "thirdName": thirdName,
        "familyName": familyName,
        "decision": decision,
        "memberPhoto": memberPhoto,
      };
}
