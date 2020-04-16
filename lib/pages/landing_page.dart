import 'package:covid_info/pages/global_page.dart';
import 'package:covid_info/pages/prevention_page.dart';
import 'package:covid_info/pages/settings_page.dart';
import 'package:covid_info/providers/country_provider.dart';
import 'package:covid_info/providers/global_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_page.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentPage = 0;

  _getPage(int page) {
    switch (page) {
      case 0:
        return GlobalPage();
      case 1:
        return CountryPage();
      case 2:
        return PreventionPage();
      case 3:
        return SettingsPage();
      default:
        return GlobalPage();
    }
  }

  @override
  void initState() {
    super.initState();
    var globalData = Provider.of<GlobalProvider>(context, listen: false);
    globalData.fetchGlobalData();
    var countryData = Provider.of<CountryProvider>(context, listen: false);
    countryData.fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.public, title: 'Global'),
            TabData(iconData: Icons.flag, title: tr('country')),
            TabData(iconData: Icons.local_hospital, title: tr('preventions')),
            TabData(iconData: Icons.settings, title: tr('settings')),
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
        body: Center(
          child: _getPage(currentPage),
        ));
  }
}
