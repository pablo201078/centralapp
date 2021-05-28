import 'package:centralApp/data/models/credito.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class CompraDetallePlan extends StatelessWidget {
  final Credito credito;

  CompraDetallePlan({Key key, this.credito});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 31.0,
      height: 17,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.2),
      ),
      padding: EdgeInsets.symmetric(horizontal:5),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Plan:',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                )),
            Text(
              '${credito.cc} de ${formatearNumeroDecimales(credito.cuota)}' ,
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
