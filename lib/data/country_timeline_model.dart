import 'package:flutter/material.dart';

class CountryTimeline {
  final String standardizedCountryName;
  final Map<dynamic, dynamic> timeline;

  CountryTimeline({
    @required this.standardizedCountryName,
    @required this.timeline,
  });

  CountryTimeline.fromJson(Map<dynamic, dynamic> json)
      : standardizedCountryName = json['standardizedCountryName'],
        timeline = json['timeline'];
}
