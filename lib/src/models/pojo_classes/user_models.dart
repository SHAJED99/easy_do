// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_do/src/controllers/services/functions/date_time_conversion.dart';

class UserModel {
  final int age;
  final String id;
  final String name;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({this.age = 0, this.id = "", this.name = "", this.email = "", this.createdAt, this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'age': age,
      '_id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt?.customToAPI,
      'updatedAt': updatedAt?.customToAPI,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      age: map['age'] as int,
      id: map['_id'].toString(),
      name: map['name'].toString(),
      email: map['email'].toString(),
      createdAt: DateTime.tryParse(map['createdAt'].toString()),
      updatedAt: DateTime.tryParse(map['updatedAt'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(age: $age, id: $id, name: $name, email: $email, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}



//     "user": {
//         "age": 20,
//         "_id": "65acf97c98a6993817d8c65a",
//         "name": "Jotno Dev",
//         "email": "user@jotno.dev",
//         "createdAt": "2024-01-21T11:01:16.506Z",
//         "updatedAt": "2024-01-27T15:07:49.043Z",
//         "__v": 116
//     },