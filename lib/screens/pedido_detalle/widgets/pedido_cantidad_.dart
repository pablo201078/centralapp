import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class PedidoCantidad extends StatelessWidget {
  final int cantidad;

  PedidoCantidad({Key key, this.cantidad});
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
            cantidad.toString(),
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 2.7,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
