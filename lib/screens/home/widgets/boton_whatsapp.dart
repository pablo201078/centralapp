import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class BotonWhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);
    return MaterialButton(
      elevation: 10.0,
      //splashColor: Colors.green,
      child: Icon(
        MaterialCommunityIcons.whatsapp,
        size: SizeConfig.safeBlockHorizontal * 17.0,
        color: Colors.green,
      ),
      onPressed: () {
        String texto = 'Hola, me gustaría contactar con un asesor';
        if (model.isLogged) {
          texto =
              'Hola soy ${model.getUser.nombre} de ${model.getUser.localidad}, necesito contactar un asesor.';
        }
        launchWhatsApp(phone: '542364326738', message: texto);
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
