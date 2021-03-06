import 'package:centralApp/data/repositories/compras.dart';
import 'package:centralApp/data/models/credito.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/widgets/compra_detalle_cuotas_restantes.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/widgets/compra_detalle_descripcion.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/widgets/compra_detalle_estado.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/widgets/compra_detalle_cuota_actual.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/widgets/historial_pago.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MisComprasDetalle extends StatelessWidget {
  Credito credito;
  int idCredito;

  MisComprasDetalle({this.credito, this.idCredito});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.credito = arguments['credito'];
    this.idCredito = arguments['idCredito'];

    //si no recibo el articulo, entonces recibo el id y tengo q descargarlo
    return this.credito != null
        ? _Scaffold(credito: this.credito)
        : _Futuro(
            idCredito: this.idCredito,
          );
  }
}

class _Scaffold extends StatelessWidget {
  final Credito credito;
  _Scaffold({this.credito});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Compra Detalle',
        actions: [],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          CompraDetalleDescripcion(credito: credito),
          SizedBox(
            height: 15,
          ),
          Divider(color: Theme.of(context).accentColor),
          CompraDetalleCuotaActual(credito: credito),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompraDetalleEstadoActual(
                credito: credito,
              ),
              CompraDetalleCuotasRestantes(credito: credito),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Theme.of(context).accentColor,
          ),
          HistorialPago(credito: credito),
        ],
      ),
    );
  }
}

class _Futuro extends StatelessWidget {
  final int idCredito;
  var comprasRepo = ComprasRepository();
  _Futuro({this.idCredito});
  @override
  Widget build(BuildContext context) {
    final UsuarioBloc loggedModel =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);

    return FutureBuilder<Credito>(
      future:
          comprasRepo.getCredito(loggedModel.getUser.idCliente, this.idCredito),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? _Scaffold(
                credito: snapshot.data,
              )
            : Center(
                child: Container(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
