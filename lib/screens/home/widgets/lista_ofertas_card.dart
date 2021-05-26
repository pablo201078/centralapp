import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';

class ListaOfertasCard extends StatelessWidget {
  final Articulo oferta;
  ListaOfertasCard({Key key, @required this.oferta});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    _buildContainer(context, imageProvider) {
      return Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Theme.of(context).accentColor,
                blurRadius: 6.0,
                offset: Offset(1.0, 7.0))
          ],
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      );
    }

    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: this.oferta.urlImagen ?? '',
        imageBuilder:
            _buildContainer, // el container es el q muestra la imagen, lo construyo aca adentro para usar cachedImages
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': this.oferta});
      },
    );
  }
}
