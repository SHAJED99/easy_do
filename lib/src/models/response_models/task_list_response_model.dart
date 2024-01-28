// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_do/src/controllers/services/functions/map_converter.dart';
import 'package:easy_do/src/models/pojo_classes/task_model.dart';

class TaskListResponseModel {
  int count;
  List<TaskModel> data;

  TaskListResponseModel({this.count = 0, this.data = const []});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskListResponseModel.fromMap(Map<String, dynamic> map) {
    return TaskListResponseModel(
      count: map['count'] as int,
      data: map.customToMapList('data').map((e) => TaskModel.fromMap(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskListResponseModel.fromJson(String source) => TaskListResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  int get totalComplete {
    int i = 0;

    for (TaskModel t in data) {
      if (t.completed) i = i + 1;
    }

    return i;
  }

  int get totalIncomplete {
    int i = 0;

    for (TaskModel t in data) {
      if (!t.completed) i = i + 1;
    }

    return i;
  }
}
