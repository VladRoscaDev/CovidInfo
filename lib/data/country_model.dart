import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Country {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;

  Country(
      {@required this.country,
      @required this.cases,
      @required this.todayCases,
      @required this.deaths,
      @required this.todayDeaths,
      @required this.recovered,
      @required this.active,
      @required this.critical,
      @required this.casesPerOneMillion});

  Country.fromJson(Map<dynamic, dynamic> json)
      : country = json['country'],
        cases = json['cases'],
        todayCases = json['todayCases'],
        deaths = json['deaths'],
        todayDeaths = json['todayDeaths'],
        recovered = json['recovered'],
        active = json['active'],
        critical = json['critical'],
        casesPerOneMillion = json['casesPerOneMillion'];
}
