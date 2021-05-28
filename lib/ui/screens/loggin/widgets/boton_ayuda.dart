import 'package:centralApp/logic/varios.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class BotonAyuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return InkWell(
      child: Icon(
        Icons.call,
        size: SizeConfig.safeBlockHorizontal * 15.0,
        color: Colors.white,
      ),
      onTap: llamar0800,
    );
  }
}
