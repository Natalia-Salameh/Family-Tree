import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
    String userName;
    String email;
    String password;

    SignupModel({
        required this.userName,
        required this.email,
        required this.password,
    });

    factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        userName: json["UserName"],
        email: json["Email"],
        password: json["Password"],
    );

    Map<String, dynamic> toJson() => {
        "UserName": userName,
        "Email": email,
        "Password": password,
    };
}
