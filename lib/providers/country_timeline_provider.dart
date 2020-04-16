import 'package:covid_info/data/country_timeline_model.dart';
import 'package:covid_info/services/data_service.dart';
import 'package:flutter/material.dart';

class CountryTimelineProvider with ChangeNotifier {
  CountryTimeline countryTimelineModel;

  Future<CountryTimeline> fetchCountryTimemline(String countryName) {
    DataService dataService = new DataService();
    return dataService.getCountryTimeline(countryName).then((result) {
      countryTimelineModel = result;
      notifyListeners();
    });
  }
}
