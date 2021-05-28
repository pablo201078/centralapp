import 'package:centralApp/data/models/credito.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class CompraCardDetalle extends StatelessWidget {
  final Credito credito;

  CompraCardDetalle({this.credito});

  String txt;

  @override
  Widget build(BuildContext context) {
    if (credito.idTipo == 1)
      txt = 'Primer Cuota ${credito.fechaAlta}';
    else
      txt = credito.actual
          ? 'Entregado el ${credito.fechaAlta}'
          : 'Finalizado el ${credito.fechaFinalizacion}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(credito.descripcion,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600),
            maxLines: 2),
        SizedBox(
          height: 7.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              txt,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
