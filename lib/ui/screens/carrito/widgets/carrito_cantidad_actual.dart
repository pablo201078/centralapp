import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class CarritoCantidadActual extends StatelessWidget {
  final Articulo articulo;

  CarritoCantidadActual({Key key, this.articulo});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 20.0,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Cantidad:',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 2.7,
              )),
          Text(
            articulo.cantidad.toString(),
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 2.7,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
