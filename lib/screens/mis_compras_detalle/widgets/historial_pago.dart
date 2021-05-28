import 'package:centralApp/data/api/compras.dart';
import 'package:centralApp/data/models/credito.dart';
import 'package:centralApp/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/widgets/elevated_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils.dart';

class HistorialPago extends StatefulWidget {
  final Credito credito;

  HistorialPago({this.credito});

  @override
  _HistorialPagoState createState() => _HistorialPagoState();
}

class _HistorialPagoState extends State<HistorialPago> {
  Future<List<Pago>> _futuro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futuro = getPagos(widget.credito.idCredito);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pago>>(
      future: _futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) return SinConexion();
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Visibility(
          visible: snapshot.data.length > 0,
          child: ElevatedCard(
            shadowColor: Theme.of(context).primaryColor.withOpacity(0.6),
            height: SizeConfig.safeBlockVertical * 60,
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              children: [
                _Encabezado(),
                Expanded(
                  child: _Detalle(pagos: snapshot.data),
                ),
                //_Total(items: items)
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 65,
      width: 300,
      child: Column(
        children: [
          Text(
            'Historial de Pagos',
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                shadows: [
                  const BoxShadow(
                    color: Colors.black54,
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 3),
          ),
          Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}

class _Detalle extends StatelessWidget {
  final List<Pago> pagos;
  _Detalle({this.pagos});

  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).accentColor,
        );
      },
      itemBuilder: (context, index) {
        return ListTile(
          dense: true,
          /*Detalle*/
          title: Text(
            '${pagos[index].fecha}',
            maxLines: 1,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeBlockHorizontal * 4,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pagos[index].anio}',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                ),
              ),
            ],
          ),
          /*Total pago*/
          trailing: Text(
            formatCurrency.format(pagos[index].monto),
            style: TextStyle(
              color: pagos[index].monto == 0
                  ? Colors.redAccent
                  : Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      itemCount: pagos.length,
    );
  }
}
