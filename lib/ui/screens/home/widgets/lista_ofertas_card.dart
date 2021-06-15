import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centralApp/responsive.dart';

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
        imageUrl: this.oferta.urlImagen,
        imageBuilder:
            _buildContainer, // el container es el q muestra la imagen, lo construyo aca adentro para usar cachedImages
        placeholder: (context, url) => _Cargando(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': this.oferta});
      },
    );
  }
}

class _Cargando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isMobile(context) ? 0.40.sw : 0.25.sw,
      width: double.infinity * 0.8,
      margin: EdgeInsets.all(20.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              color: Colors.white),
        ),
      ),
    );
  }
}
