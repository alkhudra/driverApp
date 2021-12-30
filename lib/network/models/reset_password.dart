// To parse this JSON data, do
//
//     final resetPassword = resetPasswordFromJson(jsonString);

import 'dart:convert';

ResetPassword resetPasswordFromJson(String str) => ResetPassword.fromJson(json.decode(str));

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
    ResetPassword({
        required this.email,
        required this.password,
        required this.confirmPassword,
        required this.token,
    });

    String email;
    String password;
    String confirmPassword;
    String token;

    factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "token": token,
    };
}
