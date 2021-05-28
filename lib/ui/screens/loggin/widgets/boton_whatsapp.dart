import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:centralApp/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class BotonWhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Icon(
        MaterialCommunityIcons.whatsapp,
        size: SizeConfig.safeBlockHorizontal * 15.0,
        color: Colors.white,
      ),
      onTap: () {
        String texto = 'Hola, necesito la Contraseña para la App';
        launchWhatsApp(phone: '542364270010', message: texto);
      },
    );
  }
}

void launchWhatsApp({
  @required String phone,
  @required String message,
}) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    } else {
      return 'https://api.whatsapp.com/send?phone=$phone&text=${Uri.parse(message)}';
      //return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}
