// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_do/src/models/pojo_classes/user_models.dart';

class UserResponseModel {
  final UserModel user;
  final String token;

  UserResponseModel({this.user = const UserModel(), this.token = ""});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      token: map['token']?.toString() ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) => UserResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '''UserResponseModel(
    user: ${user.toString()}, 
    token: $token
  )''';

  bool isLogin() => token.isNotEmpty && token.isNotEmpty;
}


// {
//     "user": {
//         "age": 20,
//         "_id": "65acf97c98a6993817d8c65a",
//         "name": "Jotno Dev",
//         "email": "user@jotno.dev",
//         "createdAt": "2024-01-21T11:01:16.506Z",
//         "updatedAt": "2024-01-27T15:07:49.043Z",
//         "__v": 116
//     },
//     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWFjZjk3Yzk4YTY5OTM4MTdkOGM2NWEiLCJpYXQiOjE3MDYzNjgwNjl9.kEhVaN3wODCmTbNxKF8XRUQDyk5qRGsX8NOeype5ehU"
// }