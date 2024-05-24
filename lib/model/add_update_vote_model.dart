// To parse this JSON data, do
//
//     final addUpdateVoteModel = addUpdateVoteModelFromJson(jsonString);

import 'dart:convert';

AddUpdateVoteModel addUpdateVoteModelFromJson(String str) => AddUpdateVoteModel.fromJson(json.decode(str));

String addUpdateVoteModelToJson(AddUpdateVoteModel data) => json.encode(data.toJson());

class AddUpdateVoteModel {
    String memberId;
    String vote;
    String reason;

    AddUpdateVoteModel({
        required this.memberId,
        required this.vote,
        required this.reason,
    });

    factory AddUpdateVoteModel.fromJson(Map<String, dynamic> json) => AddUpdateVoteModel(
        memberId: json["MemberId"],
        vote: json["Vote"],
        reason: json["Reason"],
    );

    Map<String, dynamic> toJson() => {
        "MemberId": memberId,
        "Vote": vote,
        "Reason": reason,
    };
}
