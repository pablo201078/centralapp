import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(
      {Key key,
      @required this.height,
      @required this.child,
      @required this.padding,
      @required this.margin,
      @required this.shadowColor})
      : super(key: key);

  final double height;
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: this.height,
      padding: this.padding,
      margin: this.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor
                .withOpacity(0.9), //Colors.blueGrey.withOpacity(0.3),
            offset: Offset(1, 3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: this.child,
    );
  }
}
