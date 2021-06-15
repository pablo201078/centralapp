import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/ui/screens/carrito/widgets/carrito_atributo.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';
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
          Text(articulo.descripcion,
              style: Theme.of(context).textTheme.subtitle2.copyWith(),
              maxLines: 2),
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
                Text(
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
