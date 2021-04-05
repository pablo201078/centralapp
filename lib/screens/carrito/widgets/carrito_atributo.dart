import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class CarritoAtributo extends StatelessWidget {
  final Articulo articulo;

  CarritoAtributo({Key key, this.articulo});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 45.0,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.2),
      ),
      child: Center(
        child: Text(
          articulo.atributo.atributo,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: SizeConfig.blockSizeHorizontal * 2.7,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
