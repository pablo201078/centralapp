import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/scoped/logged_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/logic/articulo.dart';
/*

class BotonLike extends StatefulWidget {
  final Articulo articulo;
  final color;

  BotonLike({Key key, @required this.articulo, @required this.color});

  @override
  _BotonLikeState createState() => _BotonLikeState();
}

class _BotonLikeState extends State<BotonLike> {
  bool _activo;

  @override
  void initState() {
    super.initState();
    _activo = widget.articulo.favorito;
  }

  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

    return IconButton(
      color: widget.color,
      icon: Icon(
        _activo ? Icons.favorite : Icons.favorite_border,
        size: 28,
      ),
      onPressed: () async {
        clickFavorito(widget.articulo, model);
      },
    );
  }
}
*/

class BotonLike extends StatelessWidget {
  final Articulo articulo;
  final color;

  BotonLike({Key key, @required this.articulo, @required this.color});

  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

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
