// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {

    Login({
        required this.email,
        required this.password,
        this.rememberMe,
    });

    String email;
    String password;
    bool? rememberMe;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
        rememberMe: json["rememberMe"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "rememberMe": rememberMe,
    };
}
