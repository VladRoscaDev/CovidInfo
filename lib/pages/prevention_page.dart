import 'package:covid_info/widgets/prevention_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PreventionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 100,
      child: ListView(
        children: <Widget>[
          _buildTitleRow(context),
          SizedBox(
            height: 20,
          ),
          PreventionCard(
            imagePath: 'assets/images/wash.png',
            title: tr('wash_hands'),
            description: tr('wash_hands_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/crowd.png',
            title: tr('avoid_contact'),
            description: tr('avoid_contact_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/dont-touch.png',
            title: tr('no_touch'),
            description: tr('no_touch_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/cough.png',
            title: tr('cover'),
            description: tr('cover_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/forbidden.png',
            title: tr('no_medicine'),
            description: tr('no_medicine_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/clean.png',
            title: tr('clean_all'),
            description: tr('clean_all_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/sick.png',
            title: tr('use_mask'),
            description: tr('use_mask_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/china.png',
            title: tr('made_china'),
            description: tr('made_china_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/phone.png',
            title: tr('call_urgency'),
            description: tr('call_urgency_description'),
          ),
          PreventionCard(
            imagePath: 'assets/images/dog.png',
            title: tr('animals'),
            description: tr('animals_description'),
          )
        ],
      ),
    );
  }
}

Widget _buildTitleRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        tr('preventing_virus'),
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      )
    ],
  );
}
