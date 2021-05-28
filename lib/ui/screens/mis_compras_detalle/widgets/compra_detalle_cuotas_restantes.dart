import 'package:centralApp/data/models/credito.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class CompraDetalleCuotasRestantes extends StatelessWidget {
  final Credito credito;
  CompraDetalleCuotasRestantes({this.credito});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: SizeConfig.safeBlockHorizontal * 45,
      decoration: BoxDecoration(
        //color: colorFondo.withOpacity(0.7),
        gradient: LinearGradient(
          colors: [
            Colors.grey.withOpacity(0.2),
            Colors.grey.withOpacity(0.5),
            Colors.grey.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.4, color: Colors.blueGrey),
      ),
      child: Center(
        child: Text(
          'Te faltan ${credito.cuotasRestantes - credito.adelantos} CUOTAS',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 4.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
      ),
    );
  }
}
