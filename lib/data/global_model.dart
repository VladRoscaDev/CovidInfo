import 'package:flutter/material.dart';

class Global {
  final int cases;
  final int deaths;
  final int recovered;

  Global(
      {@required this.cases, @required this.deaths, @required this.recovered});

  Global.fromJson(Map<String, dynamic> json)
      : cases = json['cases'],
        deaths = json['deaths'],
        recovered = json['recovered'];
}
