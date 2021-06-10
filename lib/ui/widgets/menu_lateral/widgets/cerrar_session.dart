import 'package:centralApp/logic/carrito.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'custom_list_tile.dart';

Future<void> createDialog(
    BuildContext context, UsuarioBloc model, CarritoModel carritoModel) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '¿Confirma salir de su cuenta?',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            MaterialButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: Text(
                'No',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            MaterialButton(
              elevation: 5.0,
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                model.cerrarSesion(carritoModel);
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: Text(
                'Si, salir',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      });
}

class CerrarSesion extends StatelessWidget {
  UsuarioBloc model;

  CerrarSesion({Key key, this.model});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final CarritoModel carrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: false);

    return Align(
      alignment: FractionalOffset.bottomCenter,
      // This container holds all the children that will be aligned
      // on the bottom and should not scroll with the above ListView
      child: Container(
        margin: EdgeInsets.only(bottom: 7.5),
        child: Column(
          children: <Widget>[
            CustomListTile(
                icon: Icons.power_settings_new,
                iconColor: Colors.redAccent.withOpacity(0.8),
                title: 'Cerrar Sesion',
                onTap: () async {
                  await createDialog(context, model, carrito);
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
