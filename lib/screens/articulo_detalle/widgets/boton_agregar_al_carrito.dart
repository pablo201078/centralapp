import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:centralApp/logic/carrito.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:centralApp/api/articulos.dart';
import 'package:centralApp/models/scoped/carrito.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../constantes.dart';
import '../../../notificaciones.dart';
import '../../../utils.dart';

class BotonAgregarAlCarrito extends StatelessWidget {
  final Articulo articulo;

  BotonAgregarAlCarrito({Key key, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    final CarritoModel carritoModel =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: true);

    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return Padding(
      padding:
          const EdgeInsets.only(left: 15, right: 15.0, top: 10, bottom: 10),
      child: MaterialButton(
        onPressed: loggedModel.isLogged && loggedModel.getUser.idTipo == 1
            ? () {
                agregarAlCarrito(context, articulo);
              }
            : null,
        height: SizeConfig.safeBlockVertical * 6.5,
        elevation: 0.0,
        splashColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              carritoModel.existe(articulo)
                  ? 'Ya lo tenes en el Carrito'
                  : 'Agregar al Carrito',
              style: TextStyle(
                color: carritoModel.existe(articulo)
                    ? Colors.white
                    : Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.safeBlockHorizontal * 4.0,
              ),
            ),
            !carritoModel.cargando
                ? _Icono(carritoModel)
                : Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
          ],
        ),
        color: carritoModel.existe(articulo)
            ? Colors.green[200]
            : Colors.blueAccent.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    );
  }

  Widget _Icono(CarritoModel carritoModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(
        carritoModel.existe(articulo) ? Icons.check : Icons.add_shopping_cart,
        color: carritoModel.existe(articulo) ? Colors.white : Colors.blueAccent,
      ),
    );
  }
}
