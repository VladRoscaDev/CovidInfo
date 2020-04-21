import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:covid_info/data/country_model.dart';
import 'package:covid_info/providers/country_provider.dart';
import 'package:covid_info/widgets/charts_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final _searchController = TextEditingController();
  List<Country> searchedCountries = [];
  bool isOnline = false;

  _handleSearch() {
    print('Asta caut:${_searchController.text}');
    Provider.of<CountryProvider>(context, listen: false)
        .searchCountry(_searchController.text);
  }

  void _clearText(CountryProvider countryProvider) {
    _searchController.clear();
    countryProvider.searchCountry("");
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  Widget _displayContentBasedOnNetwork(CountryProvider countryContainer) {
    checkConnection();
    if (isOnline) {
      if (countryContainer.searchedCountries == null) {
        _handleRefresh(context);
      }
      return countryContainer.searchedCountries == null
          ? CircularProgressIndicator()
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _clearText(countryContainer);
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          labelText: tr('country'),
                          fillColor: Colors.white70),
                    ),
                  ),
                  Expanded(
                    child: LiquidPullToRefresh(
                      showChildOpacityTransition: false,
                      onRefresh: () => _handleRefresh(context),
                      child: ListView.builder(
                          itemCount: countryContainer.searchedCountries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ChartDialog(
                                          country: countryContainer
                                              .searchedCountries[index]);
                                    });
                              },
                              child: Card(
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            countryContainer
                                                .searchedCountries[index]
                                                .country,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              " - " +
                                                  tr('cases') +
                                                  ": ${NumberFormat.decimalPattern("en_US").format(countryContainer.searchedCountries[index].cases)}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 25),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      _buildCasesRow(
                                          context,
                                          countryContainer
                                              .searchedCountries[index]),
                                      Divider(),
                                      _buildDeathsRow(
                                          context,
                                          countryContainer
                                              .searchedCountries[index]),
                                      Divider(),
                                      _buildRecoveredCriticalRow(
                                          context,
                                          countryContainer
                                              .searchedCountries[index])
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
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
    CountryProvider countryContainer = Provider.of<CountryProvider>(context);
    return _displayContentBasedOnNetwork(countryContainer);
  }

  Row _buildRecoveredCriticalRow(BuildContext context, Country country) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.arrow_upward,
              color: Colors.greenAccent,
            ),
            Text(
              " " + tr('recovered') + " ",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              NumberFormat.decimalPattern("en_US")
                  .format(country.recovered != null ? country.recovered : 0),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.warning,
              color: Colors.redAccent,
            ),
            Text(
              " " + tr('critical') + " ",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              NumberFormat.decimalPattern("en_US")
                  .format(country.critical != null ? country.critical : 0),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        )
      ],
    );
  }

  Row _buildDeathsRow(BuildContext context, Country country) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.sentiment_very_dissatisfied,
              color: Theme.of(context).accentColor,
            ),
            Text(
              " " + tr('deaths') + " ",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              NumberFormat.decimalPattern("en_US")
                  .format(country.deaths != null ? country.deaths : 0),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.sentiment_very_dissatisfied,
              color: Theme.of(context).accentColor,
            ),
            Text(
              " " + tr('today') + " ",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              NumberFormat.decimalPattern("en_US").format(
                  country.todayDeaths != null ? country.todayDeaths : 0),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Row _buildCasesRow(BuildContext context, Country country) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.people,
              color: Theme.of(context).accentColor,
            ),
            Text(
              " " + tr('today') + " ",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              NumberFormat.decimalPattern("en_US")
                  .format(country.todayCases != null ? country.todayCases : 0),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.person_pin,
              color: Theme.of(context).accentColor,
            ),
            Text(
              " " + tr('active') + " ",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              NumberFormat.decimalPattern("en_US")
                  .format(country.active != null ? country.active : 0),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ],
    );
  }

  Future<void> _handleRefresh(BuildContext context) {
    return Provider.of<CountryProvider>(context, listen: false)
        .fetchCountryData()
        .then((_) {
      print('done');
    });
  }
}
