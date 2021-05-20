import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Text(
            this.articulo.descripcion,
            style: TextStyle(
              color: Colors.black54, //Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          Text(
            'Código: ${this.articulo.codArticulo}',
            style: TextStyle(
              color: Colors.black, //Theme.of(context).accentColor,
              //  fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
