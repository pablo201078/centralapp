import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/widgets/articulo_card/widgets/articulo_card_detalles.dart';
import 'package:centralApp/widgets/articulo_card/widgets/articulo_card_imagen.dart';
import 'package:centralApp/widgets/articulo_banner_oferta.dart';
import 'package:centralApp/widgets/boton_like.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class ArticuloCard extends StatelessWidget {
  final Articulo articulo;

  ArticuloCard({Key key, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': articulo});
      },
      child: Stack(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 13,
            child: _ContenidoCard(articulo: articulo),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).accentColor,
                    style: BorderStyle.solid),
              ),
            ),
          ),
          Visibility(
            visible: articulo.oferta,
            child: Positioned(
              left: 4,
              top: -3,
              child: ArticuloBannerOferta(
                angulo: 6.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContenidoCard extends StatelessWidget {
  final Articulo articulo;

  _ContenidoCard({Key key, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: ArticuloCardImagen(articulo: articulo)),
          Expanded(flex: 2, child: ArticuloCardDetalles(articulo: articulo)),
          Visibility(
            visible: !this.articulo.usado,
            child: BotonLike(
                articulo: articulo, color: Theme.of(context).accentColor),
          ),
        ],
      ),
    );
  }
}
