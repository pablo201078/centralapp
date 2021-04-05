import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticuloCardImagenId extends StatelessWidget {
  final int idArticulo;
  final double alto;
  ArticuloCardImagenId({Key key, @required this.idArticulo, this.alto });

  @override
  Widget build(BuildContext context) {
    return idArticulo == 0
        ? Image.asset(
            'assets/imagenes/cash.png',
            height: 60,
          )
        : Image(
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
            height: alto,
            fit: BoxFit.contain,
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace stackTrace,
            ) {
              return Icon(Icons.error, size: 35);
            },
            image: CachedNetworkImageProvider(
                'http://amacar.com.ar/images/cache/product-page/articulo-${idArticulo}_0.png'),

          );
  }
}
