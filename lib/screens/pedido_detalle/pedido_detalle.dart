import 'package:centralApp/api/pedidos.dart';
import 'package:centralApp/models/pedido.dart';
import 'package:centralApp/models/scoped/pedidos.dart';
import 'package:centralApp/screens/pedido_detalle/widgets/detalle_pedido_destino.dart';
import 'package:centralApp/screens/pedido_detalle/widgets/boton_anular_pedido.dart';
import 'package:centralApp/screens/pedido_detalle/widgets/detalle_pedido_articulo.dart';
import 'package:centralApp/screens/pedido_detalle/widgets/detalle_pedido_timeline.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PedidoDetalle extends StatelessWidget {
  Pedido pedido;
  int idPedido;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.pedido = arguments['pedido'];
    this.idPedido = arguments['idPedido'];

    //si no recibo el pedido, entonces recibo el id y tengo q descargarlo
    return this.pedido != null
        ? _Scaffold(pedido: this.pedido)
        : _Futuro(
            idPedido: this.idPedido,
          );
  }
}

class _Futuro extends StatelessWidget {
  final int idPedido;
  _Futuro({this.idPedido});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pedido>(
      future: getPedido(this.idPedido),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? _Scaffold(
                pedido: snapshot.data,
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

class _Scaffold extends StatelessWidget {
  final Pedido pedido;
  _Scaffold({this.pedido});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PedidosModel>(
      model: PedidosModel(),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'Estado del Pedido', actions: []),
        body: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                DetallePedidoArticulo(pedido: pedido),
                Divider(
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                  color: Theme.of(context).accentColor,
                ),
                DetallePedidoTimeLine(pedido: pedido),
                DetallePedidoDestino(),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 0.5,
                  //color: Theme.of(context).accentColor,
                ),
                Visibility(
                  visible: (pedido.idEstado != 20) &&
                      (pedido.idEstado != 50) &&
                      (pedido.idEstado != 45),
                  child: BotonAnularPedido(
                    pedido: pedido,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
