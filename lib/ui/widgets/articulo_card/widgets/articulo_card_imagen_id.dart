import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/ui/widgets/articulo_card/widgets/articulo_card_imagen_loading.dart';
import 'package:flutter/material.dart';

class ArticuloCardImagenId extends StatelessWidget {
  final int idArticulo;
  final double alto;
  ArticuloCardImagenId({Key key, @required this.idArticulo, this.alto});
  var articuloRepository = ArticuloRepository();
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
                child: ArticuloCardImagenLoading()//CircularProgressIndicator(),
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
              articuloRepository.url_img(idArticulo, 0),
            ),
          );
  }
}
