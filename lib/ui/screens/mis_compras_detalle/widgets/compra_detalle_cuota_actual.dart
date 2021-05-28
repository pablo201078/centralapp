import 'package:centralApp/data/models/credito.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class CompraDetalleCuotaActual extends StatelessWidget {
  final Credito credito;

  CompraDetalleCuotaActual({this.credito});



  @override
  Widget build(BuildContext context) {
    String txt = '';

    if (credito.nroCuota == 0)
      txt = 'El ${credito.fechaPrimerCuota} empezas a pagar!';
    else if (credito.actual)
      txt = '${credito.hoy}, pagas la Cuota N° ${credito.nroCuota}';

    /* return ListTile(
      title: Center(
        child: Text(
          txt,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 4.6,
              color: Theme.of(context).accentColor),
        ),
      ),
    );*/
    return Padding(
      padding:
          const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 25, top: 20),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            //  color: Colors.blueAccent.withOpacity(0.6),
            borderRadius: BorderRadius.circular(5.0),
            border:
                Border.all(width: 0.4, color: Theme.of(context).primaryColor),
            gradient: LinearGradient(colors: [
              credito.nroCuota != 0 ? Theme.of(context).primaryColor: Colors.lightGreen,
              credito.nroCuota != 0 ? Theme.of(context).accentColor: Colors.lightGreen,
              credito.nroCuota != 0 ? Theme.of(context).accentColor: Colors.green,
            ])),
        child: Center(
          child: Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
