import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class QrActualizado extends StatelessWidget {
  @override
  /*Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90.0,
      height: SizeConfig.blockSizeVertical * 6.0,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(width: 0.8, color: Colors.green),
      ),
      child: Center(
        child: Text(
          'Código OK',
          style: TextStyle(
              letterSpacing: 1,
              color: Colors.white,
              fontSize: SizeConfig.blockSizeHorizontal * 4,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }*/
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90.0,
      height: SizeConfig.blockSizeVertical * 6.0,

      child: Center(
        child: Text(
          'Código OK!',
          style: TextStyle(
              letterSpacing: 1,
              color: Theme.of(context).accentColor,
              fontSize: SizeConfig.blockSizeHorizontal * 4,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
