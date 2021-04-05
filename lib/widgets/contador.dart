import 'package:flutter/material.dart';

class Contador extends StatelessWidget {
  final String txt;
  final Color colorFondo;
  final Color colorBorde;
  final Color colorTxt;

  Contador({@required this.txt, this.colorFondo, this.colorBorde, this.colorTxt});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorFondo ?? Theme.of(context).accentColor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
            width: 0.7, color: colorBorde ?? Theme.of(context).accentColor),
      ),
      width: 25,
      height: 20,
      child: Center(
        child: FittedBox(
          child: Text(
            txt,
            style: TextStyle(
                color: colorTxt??Theme.of(context).accentColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
