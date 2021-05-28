import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';

import '../../../constantes.dart';

class ArticuloCardImagen extends StatelessWidget {
  final Articulo articulo;

  ArticuloCardImagen({Key key, @required this.articulo});
  var articuloRepository = ArticuloRepository();
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'articulo-${articulo.idArticulo}',
      child: Image(
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace stackTrace,
        ) {
          return Icon(Icons.error);
        },
        fit: BoxFit.contain,
        image: CachedNetworkImageProvider(
          articuloRepository.url_img(articulo.idArticulo, 0),
        ),
      ),
    );
  }
}
