import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DetallePedidoDestino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsuarioBloc loggedModel =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);

    return Column(
      children: [
        Image.asset(
          'assets/imagenes/pedidos/pin.png',
          height: 45,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          loggedModel.getUser.comercio,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        Text(
          loggedModel.getUser.localidad,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
