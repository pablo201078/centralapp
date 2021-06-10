import 'package:badges/badges.dart';
import 'package:centralApp/logic/carrito.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/constantes.dart';
import 'package:centralApp/notificaciones.dart';

class BotonCarrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final enCarrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: true).cantidad;

    UsuarioBloc loggedModel =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: true);

    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        loggedModel.isLogged ? enCarrito.toString() : '0',
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_cart, size: sizeActions),
        onPressed: () {
          if (loggedModel.isLogged && loggedModel.getUser.idTipo == 1) {
            Navigator.pushNamed(context, '/carrito');
          } else
            showSnackBar(context, txtIniciarSesion, Colors.redAccent);
        },
      ),
    );
  }
}
