import 'package:covid_info/providers/country_provider.dart';
import 'package:covid_info/providers/country_timeline_provider.dart';
import 'package:covid_info/providers/global_provider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/landing_page.dart';

void main() => runApp(EasyLocalization(
      child: CovidInfo(),
      path: 'assets/language',
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ro', 'RO'),
      ],
    ));

class CovidInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GlobalProvider()),
        ChangeNotifierProvider.value(value: CountryProvider()),
        ChangeNotifierProvider.value(value: CountryTimelineProvider())
      ],
      child: DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) => new ThemeData(
              brightness: brightness,
              primarySwatch: brightness == Brightness.light
                  ? Colors.deepPurple
                  : Colors.grey,
              accentColor: brightness == Brightness.light
                  ? Colors.deepPurpleAccent
                  : Colors.white,
              canvasColor:
                  brightness == Brightness.light ? Colors.white : Colors.black),
          themedWidgetBuilder: (context, theme) {
            return MaterialApp(
              title: 'Covid info',
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                EasyLocalization.of(context).delegate,
              ],
              supportedLocales: EasyLocalization.of(context).supportedLocales,
              locale: EasyLocalization.of(context).locale,
              theme: theme,
              initialRoute: '/',
              routes: {
                LandingPage.routeName: (BuildContext context) => LandingPage()
              },
            );
          }),
    );
  }
}
