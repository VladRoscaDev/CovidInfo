import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid_info/providers/global_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  bool isOnline = false;
  final numberFormatter = NumberFormat("#.##", "en_US");

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isOnline = true;
      });
    } else {
      setState(() {
        isOnline = false;
      });
    }
  }

  Widget _displayContentBasedOnNetwork(GlobalProvider globalContainer) {
    checkConnection();
    final formatter = new NumberFormat("#.###");
    if (isOnline) {
      if (globalContainer.globalData == null) {
        _handleRefresh(context);
      }
      return globalContainer.globalData == null
          ? CircularProgressIndicator()
          : LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: () => _handleRefresh(context),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  _buildTitleRow(context),
                  _buildGlobalInfectedWidget(context, globalContainer),
                  _buildGlobalDeathsWidget(context, globalContainer),
                  _buildGlobalRecoveredWidget(context, globalContainer)
                ],
              ),
            );
    } else {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          tr('network'),
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 22),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalProvider globalContainer = Provider.of<GlobalProvider>(context);
    return _displayContentBasedOnNetwork(globalContainer);
  }
}

Future<void> _handleRefresh(BuildContext context) {
  return Provider.of<GlobalProvider>(context, listen: false)
      .fetchGlobalData()
      .then((_) {
    print('done');
  });
}

Widget _buildTitleRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        Icons.public,
        size: 22,
        color: Theme.of(context).accentColor,
      ),
      Text(
        'Global',
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      )
    ],
  );
}

Padding _buildGlobalRecoveredWidget(
    BuildContext context, GlobalProvider globalProvider) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.sentiment_satisfied,
                    color: Theme.of(context).accentColor,
                    size: 28,
                  ),
                  Text(
                    " " + tr('recovered'),
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 25),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    globalProvider.globalData != null
                        ? NumberFormat.decimalPattern("en_US")
                            .format(globalProvider.globalData.recovered)
                        : '-',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Padding _buildGlobalDeathsWidget(
    BuildContext context, GlobalProvider globalProvider) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Theme.of(context).accentColor,
                    size: 28,
                  ),
                  Text(
                    " " + tr('deaths'),
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 25),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    globalProvider.globalData != null
                        ? NumberFormat.decimalPattern("en_US")
                            .format(globalProvider.globalData.deaths)
                        : '-',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Padding _buildGlobalInfectedWidget(
    BuildContext context, GlobalProvider globalProvider) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.record_voice_over,
                    color: Theme.of(context).accentColor,
                    size: 28,
                  ),
                  Text(
                    " " + tr('cases'),
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 25),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    globalProvider.globalData != null
                        ? NumberFormat.decimalPattern("en_US")
                            .format(globalProvider.globalData.cases)
                        : '-',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
