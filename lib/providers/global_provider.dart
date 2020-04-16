import 'package:covid_info/data/global_model.dart';
import 'package:covid_info/services/data_service.dart';
import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  Global globalData;

  Future<Global> fetchGlobalData() {
    DataService dataService = new DataService();
    return dataService.getGlobalData().then((result) {
      globalData = result;
      print('asta e globaldata:$globalData');
      notifyListeners();
    });
  }
}
