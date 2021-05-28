import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:centralApp/logic/usuario.dart';
import 'package:centralApp/utils.dart';

class BotonSms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return InkWell(
      child: Icon(
        MaterialCommunityIcons.message_outline,
        size: SizeConfig.safeBlockHorizontal * 15.0,
        color: Colors.white,
      ),
      onTap: () {
        enviarSms(context);
      },
    );
  }
}
