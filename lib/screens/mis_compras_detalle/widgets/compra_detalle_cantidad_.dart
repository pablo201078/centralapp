import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class CompraDetalleCantidad extends StatelessWidget {
  final int cantidad;

  CompraDetalleCantidad({Key key, this.cantidad});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 22.0,
      height: 17,
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
                fontSize: SizeConfig.blockSizeHorizontal * 2.8,
              )),
          Text(
            cantidad.toString(),
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
