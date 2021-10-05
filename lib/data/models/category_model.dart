import 'package:flutter/material.dart';

class CategoryModel {
  String? title;
  int? color;
  int? id;

  CategoryModel({
    required this.title,
    required this.color,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'color': color,
      'id': id,
    };
  }

  CategoryModel.fromOject(dynamic o, int index) {
    this.title = o[index]["title"];
    this.color = o[index]["color"];
    this.id = o[index]['id'];
  }
}
