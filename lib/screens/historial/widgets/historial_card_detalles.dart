import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils.dart';

class HistorialCardDetalles extends StatelessWidget {
  final Articulo articulo;
  final bool mostrarDias;
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

  HistorialCardDetalles({Key key, @required this.articulo, this.mostrarDias});

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
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.0),
            maxLines: 2),
        SizedBox(height: 7.0,),
        Text(
          plan,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 4.5,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 7.0,),
        Visibility(
          visible: mostrarDias??false,
          child: Text(
            articulo.diasHistorial == 0 ? 'Lo viste hoy':
            'Lo viste hace ${articulo.diasHistorial} día/s',
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 3,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
