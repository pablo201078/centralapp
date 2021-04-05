import 'package:centralApp/models/articulo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';

class ArticuloCaracteristicas extends StatelessWidget {
  final Articulo articulo;

  ArticuloCaracteristicas({Key key, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    return _buildEncabezado(context, articulo.especificaciones);
  }
}

Widget _buildEncabezado(BuildContext context, String texto) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Caracteristicas Generales',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
              fontSize: SizeConfig.safeBlockHorizontal * 4.7),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2.0,
        ),
        Text(
          texto,
          textAlign: TextAlign.left,
          //style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    ),
  );
}
