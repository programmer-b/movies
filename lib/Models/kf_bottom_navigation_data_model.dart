import 'package:flutter/material.dart';

class BottomNavigationData {
  IconData? icon;
  String? name;

  BottomNavigationData({this.icon, this.name});

  BottomNavigationData.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['name'] = name;
    return data;
  }
}