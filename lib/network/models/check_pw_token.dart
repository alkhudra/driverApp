// To parse this JSON data, do
//
//     final checkPasswordToken = checkPasswordTokenFromJson(jsonString);

import 'dart:convert';

CheckPasswordToken checkPasswordTokenFromJson(String str) => CheckPasswordToken.fromJson(json.decode(str));

String checkPasswordTokenToJson(CheckPasswordToken data) => json.encode(data.toJson());

class CheckPasswordToken {
    CheckPasswordToken({
        required this.email,
        required this.token,
    });

    String email;
    String token;

    factory CheckPasswordToken.fromJson(Map<String, dynamic> json) => CheckPasswordToken(
        email: json["email"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "token": token,
    };
}
