import 'dart:convert';

SendEmailModel sendEmailModelFromJson(String str) =>
    SendEmailModel.fromJson(json.decode(str));

String sendEmailModelToJson(SendEmailModel data) => json.encode(data.toJson());

class SendEmailModel {
  String email;

  SendEmailModel({
    required this.email,
  });

  factory SendEmailModel.fromJson(Map<String, dynamic> json) => SendEmailModel(
        email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
      };
}
