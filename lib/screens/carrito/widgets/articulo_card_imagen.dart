import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';

class ArticuloCardImagen extends StatelessWidget {
  final Articulo articulo;
  var articuloRepository = ArticuloRepository();

  ArticuloCardImagen({Key key, @required this.articulo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle_galeria',
            arguments: {'articulo': articulo, 'actual': 0});
      },
      child: Padding(
        padding: const EdgeInsets.all(7.0),
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
          fit: BoxFit.fill,
          image: CachedNetworkImageProvider(
            articuloRepository.url_img(articulo.idArticulo, 0),
          ),
        ),
      ),
    );
  }
}
