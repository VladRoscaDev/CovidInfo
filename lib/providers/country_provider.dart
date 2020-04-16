import 'package:covid_info/data/country_model.dart';
import 'package:covid_info/services/data_service.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  List<Country> allCountries;
  List<Country> searchedCountries;

  Future<List<Country>> fetchCountryData() {
    DataService dataService = new DataService();
    return dataService.getCountryData().then((result) {
      allCountries = result;
      searchedCountries = allCountries;
      print('astea sunt toate tarile:$allCountries');
      notifyListeners();
    });
  }

  void searchCountry(String countryString) {
    searchedCountries = allCountries
        .where((country) =>
            country.country.toLowerCase().contains(countryString.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
