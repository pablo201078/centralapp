import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/logic/articulo.dart';

class BotonLike extends StatelessWidget {
  final Articulo articulo;
  final color;

  BotonLike({Key key, @required this.articulo, @required this.color});

  @override
  Widget build(BuildContext context) {
    final UsuarioBloc model =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: true);

    return IconButton(
      color: color,
      icon: Icon(
        articulo.favorito ? Icons.favorite : Icons.favorite_border,
        size: 28,
      ),
      onPressed: () async {
        clickFavorito(articulo, model);
      },
    );
  }
}
