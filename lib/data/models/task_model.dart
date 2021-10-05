import 'package:flutter/material.dart';

class TaskModel {
  Color indicatorColor;
  String title;
  String category;
  bool isRepeatable;
  int repeatDays;
  bool isRemind;
  bool isCompleted;
  List<SubTask> subtasks;
  String? remindDate;

  TaskModel({
    required this.indicatorColor,
    required this.title,
    required this.repeatDays,
    required this.category,
    required this.isRepeatable,
    required this.isRemind,
    required this.subtasks,
    required this.isCompleted,
    this.remindDate = '',
  });
}

class SubTask {
  String title;
  bool isCompleted;

  SubTask({
    required this.title,
    this.isCompleted = false,
  });
}
