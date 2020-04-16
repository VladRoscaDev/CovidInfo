import 'package:covid_info/data/country_model.dart';
import 'package:covid_info/data/country_timeline_model.dart';
import 'package:covid_info/data/global_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  var globalUrl = 'https://coronavirus-19-api.herokuapp.com/all';
  var countriesUrl = 'https://coronavirus-19-api.herokuapp.com/countries';
  var countryTimelineUrl = 'https://corona.lmao.ninja/historical/';

  Future<Global> getGlobalData() async {
    var response = await http.get(globalUrl);
    if (response.statusCode == 200) {
      Global data = Global.fromJson(json.decode(response.body));
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<List<Country>> getCountryData() async {
    var response = await http.get(countriesUrl);
    if (response.statusCode == 200) {
      Iterable responseArray = json.decode(response.body);
      List<Country> countryList = responseArray
          .map((dynamic model) => Country.fromJson(model))
          .toList();
      return countryList;
    }
    print('Request failed with status:${response.statusCode}.');
    return null;
  }

  Future<CountryTimeline> getCountryTimeline(String countryName) async {
    var response = await http.get(countryTimelineUrl + countryName);
    if (response.statusCode == 200) {
      CountryTimeline countryTimelineModel =
          CountryTimeline.fromJson(json.decode(response.body));
      return countryTimelineModel;
    }
  }
}
