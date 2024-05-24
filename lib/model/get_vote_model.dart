// To parse this JSON data, do
//
//     final getVoteModel = getVoteModelFromJson(jsonString);

import 'dart:convert';

GetVoteModel getVoteModelFromJson(String str) => GetVoteModel.fromJson(json.decode(str));

String getVoteModelToJson(GetVoteModel data) => json.encode(data.toJson());

class GetVoteModel {
    String id;
    String memberId;
    String vote;
    String reason;

    GetVoteModel({
        required this.id,
        required this.memberId,
        required this.vote,
        required this.reason,
    });

    factory GetVoteModel.fromJson(Map<String, dynamic> json) => GetVoteModel(
        id: json["id"],
        memberId: json["memberId"],
        vote: json["vote"],
        reason: json["reason"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "memberId": memberId,
        "vote": vote,
        "reason": reason,
    };
}
