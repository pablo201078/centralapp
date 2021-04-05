import 'package:auto_size_text/auto_size_text.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:centralApp/screens/carrito/widgets/carrito_atributo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils.dart';
import 'carrito_cantidad_actual.dart';

class ArticuloCardDetalles extends StatelessWidget {
  final Articulo articulo;
  ArticuloCardDetalles({Key key, @required this.articulo});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(articulo.descripcion,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 2.0),
              maxLines: 3),
          Visibility(
            visible: articulo.tieneAtributo,
            child: CarritoAtributo(
              articulo: articulo,
            ),
          ),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CarritoCantidadActual(
                  articulo: articulo,
                ),
                /*plan actual*/
                AutoSizeText(
                  '${articulo.cc} de ${formatearNumero(articulo.planActual)}',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 2.7,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
