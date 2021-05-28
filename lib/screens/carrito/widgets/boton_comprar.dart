import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/repositories/pedidos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/scoped/carrito.dart';
import 'package:centralApp/logic/scoped/logged_model.dart';
import 'package:centralApp/logic/scoped/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../notificaciones.dart';
import '../../../utils.dart';

class BotonComprar extends StatefulWidget {
  final Articulo articulo;

  BotonComprar({Key key, @required this.articulo});

  @override
  _BotonComprarState createState() => _BotonComprarState();
}

class _BotonComprarState extends State<BotonComprar> {
  bool cargando = false;
  var articuloRepository = ArticuloRepository();
  @override
  Widget build(BuildContext context) {
    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);
    final CarritoModel carritoModel =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: true);
    final PedidosModel pedidosModel =
        ScopedModel.of<PedidosModel>(context, rebuildOnChange: false);

    void click() async {
      if (cargando) return;
      setState(() {
        cargando = true;
      });
      bool rta = await articuloRepository.comprarCarrito(loggedModel.getUser.idCliente, context);
      pedidosModel.pedidos = await getPedidos(loggedModel.getUser.idCliente);
      setState(() {
        cargando = false;
      });
      if (rta) {
        VoidCallback ok = () async {
          carritoModel.vaciar();

          Navigator.popUntil(context, ModalRoute.withName('/'));
        };
        showFinCompra(context, ok);
      } else
        showSnackBar(context, 'Algo salio mal', Colors.redAccent);
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: click,
        height: SizeConfig.safeBlockVertical * 5.5,
        elevation: 0.0,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 30,
          child: Center(
            child: cargando
                ? Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                : Text(
                    'Finalizar Compra',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.0,
                    ),
                  ),
          ),
        ),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      ),
    );
  }
}
