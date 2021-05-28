import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';

class ArticuloDescripcion extends StatelessWidget {
  const ArticuloDescripcion({
    Key key,
    @required this.articulo,
  }) : super(key: key);

  final Articulo articulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.articulo.descripcion,
              style: Theme.of(context).textTheme.headline6),
          Text('Código: ${this.articulo.codArticulo}',
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}
