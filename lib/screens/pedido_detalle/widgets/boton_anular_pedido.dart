import 'package:centralApp/data/repositories/pedidos.dart';
import 'package:centralApp/data/models/pedido.dart';
import 'package:centralApp/data/scoped/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../notificaciones.dart';
import '../../../utils.dart';

class BotonAnularPedido extends StatefulWidget {
  final Pedido pedido;

  BotonAnularPedido({@required this.pedido});

  @override
  _BotonAnularPedidoState createState() => _BotonAnularPedidoState();
}

class _BotonAnularPedidoState extends State<BotonAnularPedido> {
  bool cargando = false;

  @override
  Widget build(BuildContext context) {
    void click() async {
      if (widget.pedido.idEstado != 10 && widget.pedido.idEstado != 35 ) {
        showSnackBar(
            context,
            'Comunicate con tu Cobradora para cancelar este pedido.',
            Colors.blueAccent);
        return;
      }

      if (this.cargando) return;

      setState(() {
        this.cargando = true;
      });

      bool rta = await anularPedido(this.widget.pedido.id, context);
      setState(() {
        this.cargando = false;
      });
      if (rta) {
        PedidosModel pedidos =
            ScopedModel.of<PedidosModel>(context, rebuildOnChange: false);
        pedidos.eliminar(widget.pedido);
        showMessage(context, 'Tu Pedido fué cancelado', null);
        Navigator.popUntil(context, ModalRoute.withName('/pedidos'));
      }
    }

    return Padding(
      padding:
          const EdgeInsets.only(left: 15, right: 15.0, top: 10, bottom: 10),
      child: MaterialButton(
        onPressed: click,
        height: SizeConfig.safeBlockVertical * 6.5,
        minWidth: SizeConfig.safeBlockHorizontal * 80,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cancelar Pedido',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.safeBlockHorizontal * 4.0,
              ),
            ),
            Visibility(
              visible: cargando,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
        color: Colors.red.withOpacity(0.9), //Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      ),
    );
  }
}
