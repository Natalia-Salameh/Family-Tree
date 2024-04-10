import 'dart:convert';

VerifyEmailModel verifyEmailModelFromJson(String str) => VerifyEmailModel.fromJson(json.decode(str));

String verifyEmailModelToJson(VerifyEmailModel data) => json.encode(data.toJson());

class VerifyEmailModel {
    String email;
    String code;

    VerifyEmailModel({
        required this.email,
        required this.code,
    });

    factory VerifyEmailModel.fromJson(Map<String, dynamic> json) => VerifyEmailModel(
        email: json["Email"],
        code: json["Code"],
    );

    Map<String, dynamic> toJson() => {
        "Email": email,
        "Code": code,
    };
}
