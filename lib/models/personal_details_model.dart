import 'package:flutter/material.dart';

class PersonalDetailsModel {
  final String id;
  String name;
  String surname;
  String cellNumber;
  bool hasData = false;

  PersonalDetailsModel(
      {@required this.id,
      @required this.name,
      @required this.surname,
      @required this.cellNumber}) {
    if (null != id || null != name || null != surname || null != cellNumber) {
      hasData = true;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'cellNumber': cellNumber,
    };
  }
}
