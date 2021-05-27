import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:centralApp/api/articulos.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:centralApp/models/scoped/carrito.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../notificaciones.dart';

void agregarAlCarrito(BuildContext context, Articulo articulo) async {
  final CarritoModel carritoModel =
      ScopedModel.of<CarritoModel>(context, rebuildOnChange: false);

  final LoggedModel loggedModel =
      ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

  if (carritoModel.cargando) return;

  if (articulo.atributo.idAtributo == 0 && articulo.tieneAtributo) {
    showMessage(
        context, 'Tenés que elegir de que tipo es.', DialogType.WARNING);
    return;
  }

  carritoModel.cargando = true;

  bool rta = await actualizarCarrito(
      articulo, loggedModel.getUser.idCliente, true, context);

  carritoModel.cargando = false;

  if (rta) {
    carritoModel.agregar(articulo);
    Navigator.pushNamed(context, '/carrito');
  }
}
