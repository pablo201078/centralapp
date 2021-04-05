import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';

class ArticuloCardImagen extends StatelessWidget {

  final Articulo articulo;

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
                'https://amacar.com.ar/images/cache/product-page/articulo-${articulo.idArticulo}_0.png')),
      ),
    );
  }
}
