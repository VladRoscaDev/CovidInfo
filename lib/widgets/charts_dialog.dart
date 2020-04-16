import 'package:covid_info/data/country_timeline_model.dart';
import 'package:covid_info/providers/country_timeline_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../data/country_model.dart';

class ChartDialog extends StatefulWidget {
  Country country;
  ChartDialog({@required this.country});
  @override
  _ChartDialogState createState() => _ChartDialogState();
}

class _ChartDialogState extends State<ChartDialog> {
  int touchedIndex;
  Map<String, double> dataMap = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var countryTimelineProvider =
        Provider.of<CountryTimelineProvider>(context, listen: false);
    countryTimelineProvider.fetchCountryTimemline(widget.country.country);
  }

  void _initDataMap() {
    dataMap.putIfAbsent(tr('cases'), () => widget.country.cases.toDouble());
    dataMap.putIfAbsent(tr('deaths'), () => widget.country.deaths.toDouble());
    if (Localizations.localeOf(context) == Locale('en', 'US')) {
      dataMap.putIfAbsent(tr('today') + ' ' + tr('deaths'),
          () => widget.country.todayDeaths.toDouble());
    } else {
      dataMap.putIfAbsent(tr('deaths') + ' ' + tr('today'),
          () => widget.country.todayDeaths.toDouble());
    }
    dataMap.putIfAbsent(
        tr('recovered'), () => widget.country.recovered.toDouble());
    dataMap.putIfAbsent(tr('active'), () => widget.country.active.toDouble());
    dataMap.putIfAbsent(
        tr('critical'), () => widget.country.critical.toDouble());
    if (Localizations.localeOf(context) == Locale('en', 'US')) {
      dataMap.putIfAbsent(tr('today') + ' ' + tr('cases'),
          () => widget.country.todayCases.toDouble());
    } else {
      dataMap.putIfAbsent(tr('cases') + ' ' + tr('today'),
          () => widget.country.todayCases.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    var countryTimeline =
        Provider.of<CountryTimelineProvider>(context, listen: false);
    print(
        'country timeline:${countryTimeline.countryTimelineModel.timeline.toString()}');
    var country = widget.country;
    _initDataMap();
    return AlertDialog(
      title: Text(
        country.country,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PieChart(
              dataMap: dataMap,
              showChartValueLabel: false,
              showChartValues: false,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              chartLegendSpacing: 15,
              chartRadius: MediaQuery.of(context).size.width - 120,
              chartType: ChartType.disc,
              legendPosition: LegendPosition.bottom,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
