import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:centralApp/utils.dart';
import 'numeracion_imagen.dart';

class ArticuloDetalleGaleria extends StatelessWidget {
  Articulo articulo;
  int actual;

  ArticuloDetalleGaleria(
      {Key key, @required this.articulo, @required this.actual})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.articulo = arguments['articulo'];
    this.actual = arguments['actual'];

    return Scaffold(
      body: Stack(children: [
        Galeria(articulo: this.articulo, actual: this.actual),
        Positioned(
          top: 40,
          left: 15,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: SizeConfig.blockSizeHorizontal * 9.0,
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ]),
    );
  }
}

class Galeria extends StatefulWidget {
  final Articulo articulo;
  int actual;

  Galeria({Key key, @required this.articulo, @required this.actual});

  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  var articuloRepository = ArticuloRepository();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Hero(
            tag: 'articulo-${widget.articulo.idArticulo}',
            child: Container(
              height: SizeConfig.safeBlockVertical * 100,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(
                      articuloRepository.url_img(
                          widget.articulo.idArticulo, index),
                    ),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    minScale: PhotoViewComputedScale.contained * 1,
                  );
                },
                itemCount: widget.articulo.imagenes,
                onPageChanged: (index) {
                  setState(() {
                    widget.actual = index;
                  });
                },
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                backgroundDecoration: const BoxDecoration(color: Colors.white),
                pageController: PageController(
                  initialPage: widget.actual,
                ),
              ),
            ),
          ),
          NumeracionImagen(
            texto: (widget.actual + 1).toString() +
                ' / ${widget.articulo.imagenes}',
            top: 160.0,
            left: 25.0,
          ),
        ],
      ),
    );
  }
}
