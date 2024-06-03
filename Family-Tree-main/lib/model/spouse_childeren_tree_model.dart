import 'dart:convert';

List<GetTreeModel> getTreeModelFromJson(String str) => List<GetTreeModel>.from(
    json.decode(str).map((x) => GetTreeModel.fromJson(x)));

String getTreeModelToJson(List<GetTreeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTreeModel {
  String marriageId;
  String marriageStatus;
  Spouse spouse;
  List<Spouse> children;

  GetTreeModel({
    required this.marriageId,
    required this.marriageStatus,
    required this.spouse,
    required this.children,
  });

  factory GetTreeModel.fromJson(Map<String, dynamic> json) => GetTreeModel(
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
