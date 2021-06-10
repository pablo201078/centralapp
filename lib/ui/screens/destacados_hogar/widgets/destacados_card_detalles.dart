import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class DestacadosCardDetalles extends StatelessWidget {
  final Articulo articulo;
  DestacadosCardDetalles({Key key, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    String plan;
    if (articulo.en250 != 0) {
      plan =
          '250   de   ${articulo.oferta ? formatearNumero(articulo.en250bon) : formatearNumero(articulo.en250)}';
    } else
      plan =
          '200   de   ${articulo.oferta ? formatearNumero(articulo.en200bon) : formatearNumero(articulo.en200)}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(articulo.descripcion,
            style: Theme.of(context).textTheme.caption,
            maxLines: 2),
        SizedBox(
          height: 7.0,
        ),
        Text(
          plan,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 4.5,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
