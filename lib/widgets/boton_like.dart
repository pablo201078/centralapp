import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/data/scoped/logged_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../constantes.dart';
import '../notificaciones.dart';

class BotonLike extends StatefulWidget {
  final Articulo articulo;
  final color;

  BotonLike({Key key, @required this.articulo, @required this.color});

  @override
  _BotonLikeState createState() => _BotonLikeState();
}

class _BotonLikeState extends State<BotonLike> {
  bool activo;

  @override
  void initState() {
    super.initState();
    activo = widget.articulo.favorito;
  }

  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);
    var articuloRepository = ArticuloRepository();
    return IconButton(
      color: widget.color,
      icon: Icon(
        activo ? Icons.favorite : Icons.favorite_border,
        size: 28,
      ),
      onPressed: () async {
        if (model.isLogged && model.getUser.idTipo == 1) {
          bool rta = await articuloRepository.postFavorito(
            widget.articulo,
            model.getUser.idCliente,
            !activo,
            context,
          );

          if (rta) {
            if (activo)
              model.eliminarFavorito(widget.articulo);
            else
              model.agregarFavorito(widget.articulo);
            widget.articulo.setFav = !activo;
            setState(() {
              activo = !activo;
            });
          }
        } else
          showSnackBar(context, txtIniciarSesion, Colors.redAccent);
      },
    );
  }
}
