import 'package:flutter/material.dart';
import 'dart:math';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/logic/scoped/logged_model.dart';
import '../../../utils.dart';

class ImagenSocio extends StatelessWidget {
  ImageProvider imagenPerfil;

  @override
  Widget build(BuildContext context) {
    final LoggedModel modelo =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    if (modelo.getUser.imagen != '') {
      imagenPerfil = Image.network(
        modelo.getUser.imagen,
        key: ValueKey(
          Random().nextInt(100),
        ),
      ).image;
    } else
      imagenPerfil = Image.asset('assets/imagenes/usuario.png').image;

    return Container(
      width: SizeConfig.safeBlockVertical * 12,
      height: SizeConfig.safeBlockVertical * 12,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        image: DecorationImage(image: imagenPerfil, fit: BoxFit.cover),
      ),
    );
  }
}
