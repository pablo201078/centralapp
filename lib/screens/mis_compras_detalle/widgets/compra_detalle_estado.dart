import 'package:centralApp/models/credito.dart';
import 'package:centralApp/screens/mis_compras_detalle/widgets/compra_detalle_deuda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils.dart';

class CompraDetalleEstadoActual extends StatelessWidget {
  final Credito credito;
  CompraDetalleEstadoActual({this.credito});
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
  @override
  Widget build(BuildContext context) {
    String txt;
    Color colorFondo;
    Color color;

    //print('Deuda: ' + formatCurrency.format(double.parse(credito.deuda)) );

    if (credito.actual) {
      if (credito.deuda > 0) {
        txt = 'Atrasado    ${formatCurrency.format(credito.deuda)}';
        color = Colors.white;
        colorFondo = Colors.redAccent;
      } else if (credito.adelantos > 0) {
        txt = 'Tenés ${credito.adelantos} CUOTAS adelantadas';
        color = Colors.blueAccent;
        colorFondo = Colors.transparent;
      } else {
        txt = 'Estás al Día!';
        color = Colors.black;
        colorFondo = Colors.transparent;
      }
    } else {
      txt = 'Finalizado';
      color = Colors.white;
      colorFondo = Colors.green;
    }

    //   txt = 'Tenés 100 cuotas adelantadas';
    //   color = Colors.blueAccent;

    return Container(
      height: 45,
      alignment: Alignment.topCenter,
      width: SizeConfig.safeBlockHorizontal * (credito.actual ? 45 : 80),
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.4, color: color),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (credito.deuda > 0)
              ? () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return CompraDetalleDeuda(
                        idCredito: credito.idCredito,
                      );
                    },
                  );
                }
              : null,
          child: Center(
            child: Text(
              txt,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
