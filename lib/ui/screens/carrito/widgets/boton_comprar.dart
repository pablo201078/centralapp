import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/carrito.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/utils.dart';

class BotonComprar extends StatelessWidget {
  final Articulo articulo;
  BotonComprar({Key key, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    final CarritoModel carritoModel =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: true);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: () {
          carritoModel.comprarCarrito(context);
        },
        height: SizeConfig.safeBlockVertical * 5.5,
        elevation: 0.0,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 30,
          child: Center(
            child: carritoModel.cargando
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    );
  }
}
