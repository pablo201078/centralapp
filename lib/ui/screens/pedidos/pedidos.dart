import 'package:centralApp/data/repositories/pedidos.dart';
import 'package:centralApp/data/models/pedido.dart';
import 'package:centralApp/logic/scoped/pedidos.dart';
import 'package:centralApp/ui/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/ui/screens/pedidos/widgets/pedido_card.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Pedidos extends StatelessWidget {
  int idCliente;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.idCliente = arguments['idCliente'];
    // TODO: implement build

    return ScopedModel<PedidosModel>(
      model: PedidosModel(),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'Mis Pedidos', actions: []),
        body: _Body(idCliente: idCliente),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int idCliente;

  _Body({this.idCliente});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  Future<List<Pedido>> _futuro;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futuro = getPedidos(widget.idCliente);
  }

  @override
  Widget build(BuildContext context) {
    PedidosModel pedidos =
        ScopedModel.of<PedidosModel>(context, rebuildOnChange: false);

    return FutureBuilder<List<Pedido>>(
      future: _futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) return SinConexion();
        if (!snapshot.hasData) return LoadingList(itemsCount: 7);
        if (snapshot.data.length == 0) return _SinPedidos();

        pedidos.pedidos = snapshot.data;
        return _Lista();
      },
    );
  }
}

class _SinPedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "No tenes ningún pedido",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 20),
          ),
        ),
     //   BotonEmpezarAComprar(),
      ],
    );
  }
}

class _Lista extends StatelessWidget {
  // final List<Pedido> pedidos;

  //_Lista({this.pedidos});

  @override
  Widget build(BuildContext context) {
    PedidosModel pedidos =
        ScopedModel.of<PedidosModel>(context, rebuildOnChange: true);

    return ListView.builder(
      itemBuilder: (context, index) {
        return PedidoCard(pedido: pedidos.pedidos[index]);
      },
      itemCount: pedidos.pedidos.length,
    );
  }
}
