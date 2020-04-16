import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var dropdownValue = 'Romana';
  bool isDarkTheme = true;

  void setCorrectTheme(BuildContext context) {
    if (DynamicTheme.of(context).brightness == Brightness.light) {
      isDarkTheme = false;
    } else {
      isDarkTheme = true;
    }
  }

  void setCorrectLocale(BuildContext context) {
    if (Localizations.localeOf(context) == Locale('en', 'US')) {
      dropdownValue = 'English';
    } else {
      dropdownValue = 'Romana';
    }
  }

  @override
  Widget build(BuildContext context) {
    setCorrectLocale(context);
    setCorrectTheme(context);
    var data = EasyLocalization.of(context).locale;
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).primaryColor
          : Colors.black,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  tr('adjust_settings'),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 160.0,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey[800],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(75.0),
              ),
            ),
            child: Column(children: <Widget>[
              SizedBox(
                height: 20,
              ),
              _buildLanguageRow(data),
              Divider(
                height: 2,
              ),
              _buildThemeRow(context),
              Divider(
                height: 2,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buildCreditsRow(context),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Row _buildCreditsRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 50,
          width: MediaQuery.of(context).size.width - 50,
          child: Text(
              'All icons from the app are made by Pixel perfect from www.flaticon.com'),
        )
      ],
    );
  }

  Row _buildThemeRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          tr('select_theme'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Switch(
            inactiveThumbColor: Colors.yellow,
            activeColor: Colors.grey,
            activeTrackColor: Colors.blueGrey,
            value: isDarkTheme,
            onChanged: (value) {
              setState(() => isDarkTheme = value);
              DynamicTheme.of(context).setBrightness(
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark);
            }),
      ],
    );
  }

  Row _buildLanguageRow(var data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          tr(
            'select_language',
          ),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        DropdownButton(
          style: Theme.of(context).textTheme.body1,
          value: dropdownValue,
          icon: Icon(Icons.language),
          iconSize: 24,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
            if (newValue == 'Romana') {
              EasyLocalization.of(context).locale = Locale('ro', 'RO');
            } else {
              EasyLocalization.of(context).locale = Locale('en', 'US');
            }
          },
          items: <String>['Romana', 'English']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
