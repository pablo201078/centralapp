import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/scoped/carrito.dart';
import 'package:centralApp/logic/scoped/logged_model.dart';
import 'package:centralApp/notificaciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../constantes.dart';
import '../../../theme.dart';
import '../../../utils.dart';
import 'articulo_card_detalles.dart';
import 'articulo_card_imagen.dart';

class ArticuloCard extends StatelessWidget {
  ArticuloCard({Key key, this.index, this.articulo, this.listKey})
      : super(key: key);

  final int index;
  final Articulo articulo;
  final GlobalKey<AnimatedListState> listKey;
  var articuloRepository = ArticuloRepository();
  @override
  Widget build(BuildContext context) {
    CarritoModel carrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: true);

    LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    void eliminarDelCarrito() async {
      bool rta = await articuloRepository.actualizarCarrito(
          articulo, loggedModel.getUser.idCliente, false);

      if (rta) {
        showSnackBar(context, txtEliminasteDelCarrito, Colors.blueAccent);
        HapticFeedback.lightImpact();
        //para la animacion
        listKey.currentState.removeItem(
          index,
          (context, animation) {
            return FadeTransition(
              opacity:
                  CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
              child: SizeTransition(
                sizeFactor: CurvedAnimation(
                    parent: animation, curve: Interval(0.0, 1.0)),
                axisAlignment: 0.0,
                child: _buildCard(index, context, articulo, null),
              ),
            );
          },
          duration: Duration(milliseconds: 550),
        );
        Future.delayed(Duration.zero, () {
          carrito.eliminar(articulo);
        });
      } else
        showSnackBar(context, 'Oops, algo salio mal.', Colors.red);
    }

    return _buildCard(index, context, articulo, eliminarDelCarrito);
  }
}

Widget _buildCard(
    int index, BuildContext context, Articulo articulo, VoidCallback eliminar) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    height: SizeConfig.safeBlockVertical * 12,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: index.isEven
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
            boxShadow: [kDefaultShadow],
          ),
          child: Container(
            margin: EdgeInsets.only(right: 7.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
          ),
        ),
        ArticuloCardContenido(articulo: articulo),
        /* Boton para sacar del carrito*/
        Positioned(
          top: 5,
          right: 9,
          child: GestureDetector(
            onTap: eliminar,
            child: Icon(Icons.close, size: 26),
          ),
        )
      ],
    ),
  );
}

class ArticuloCardContenido extends StatelessWidget {
  final Articulo articulo;
  ArticuloCardContenido({Key key, @required this.articulo});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ArticuloCardImagen(articulo: articulo),
        ArticuloCardDetalles(articulo: articulo),
      ],
    );
  }
}
