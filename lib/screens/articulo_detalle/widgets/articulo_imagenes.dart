import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/numeracion_imagen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../utils.dart';
import '../../../widgets/articulo_banner_oferta.dart';
import 'boton_compartir.dart';

class ArticuloImagenes extends StatefulWidget {
  const ArticuloImagenes({
    Key key,
    @required this.articulo,
  }) : super(key: key);

  final Articulo articulo;

  @override
  _ArticuloImagenesState createState() => _ArticuloImagenesState();
}

class _ArticuloImagenesState extends State<ArticuloImagenes> {
  int imagenActual = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.safeBlockVertical * 30.0,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: Swiper(
            autoplayDisableOnInteraction: true,
            autoplay: true,
            autoplayDelay: 15000,
            layout: SwiperLayout.DEFAULT,
            loop: false,
            itemCount: this.widget.articulo.imagenes,
            onIndexChanged: (index) {
              setState(() {
                this.imagenActual = index + 1;
              });
            },
            itemBuilder: (context, i) {
              print('${widget.articulo.urlImagenBase}$i.png');
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/articulo_detalle_galeria',
                      arguments: {'articulo': widget.articulo, 'actual': i});
                },
                child: Hero(
                  tag: 'articulo-${widget.articulo.idArticulo}',
                  child: _Imagen(
                    url:
                        'http://amacar.com.ar/images/cache/product-page/articulo-${widget.articulo.idArticulo}_$i.png',
                    articulo: widget.articulo,
                  ),
                ),
              );
            },
          ),
        ),
        //cartelito q dice en que nro de imagen estoy
        NumeracionImagen(
          texto: '$imagenActual / ${widget.articulo.imagenes}',
          top: 20.0,
          left: 25.0,
        ),
        Visibility(
          visible: widget.articulo.oferta,
          child: Positioned(
            right: -5,
            top: 13.2,
            child: ArticuloBannerOferta(
              angulo: 1,
            ),
          ),
        ),

        Visibility(
          visible: !widget.articulo.usado,
          child: Positioned(
              bottom: 20.0,
              right: 14.0,
              child: BotonCompartir(link: widget.articulo.link)),
        )
      ],
    );
  }
}

class _Imagen extends StatelessWidget {
  final String url;
  final Articulo articulo;

  _Imagen({@required this.url, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _buildContainer(context, imageProvider) {
      return Card(
        elevation: 8.0,
        margin: EdgeInsets.only(left: 10, top: 10, bottom: 15, right: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: this.url,
      imageBuilder:
          _buildContainer, // el container es el q muestra la imagen, lo construyo aca adentro para usar cachedImages
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error, size: 30),
    );
  }
}
