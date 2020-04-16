import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

class PreventionCard extends StatelessWidget {
  String imagePath;
  String title;
  String description;

  PreventionCard(
      {@required this.imagePath,
      @required this.title,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    imagePath,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ExpandChild(
              child: Text(
                description,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
