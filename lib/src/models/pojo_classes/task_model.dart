import 'dart:convert';

import 'package:easy_do/src/controllers/services/functions/date_time_conversion.dart';

class TaskModel {
  bool completed;
  String sId;
  String title;
  String description;
  DateTime dueDate;
  String owner;
  DateTime createdAt;
  DateTime updatedAt;

  TaskModel({
    this.completed = false,
    this.sId = "",
    this.title = "",
    this.description = "",
    DateTime? dueDate,
    this.owner = "",
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : dueDate = dueDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'completed': completed,
      '_id': sId,
      'title': title,
      'description': description,
      'dueDate': dueDate.customToAPI,
      'owner': owner,
      'createdAt': createdAt.customToAPI,
      'updatedAt': updatedAt.customToAPI,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      completed: (map['completed'] ?? false) as bool,
      sId: map['_id'].toString(),
      title: map['title'].toString(),
      description: map['description'].toString(),
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate'].toString()) : null,
      owner: map['owner'].toString(),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt'].toString()) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
