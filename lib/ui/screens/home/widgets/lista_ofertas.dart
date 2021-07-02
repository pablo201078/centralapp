import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:shimmer/shimmer.dart';
import 'lista_ofertas_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListaOfertas extends StatelessWidget {
  Future<List<Articulo>> futuro;

  ListaOfertas({@required this.futuro});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<Articulo>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Icon(Icons.error_outline);
        if (!snapshot.hasData) return _Cargando();
        if (snapshot.data.isEmpty) return _Cargando();
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return _Container(
            ofertas: snapshot.data,
          );
        }
        return _Cargando();
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
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              shape: BoxShape.rectangle,
              color: Colors.white),
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  final List<Articulo> ofertas;
  _Container({this.ofertas});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isMobile(context) ? 0.46.sw : 0.25.sw,
      width: double.infinity,
      margin: EdgeInsets.only(left: 10),
      child: Swiper(
        layout: SwiperLayout.STACK, // TINDER,
        viewportFraction: 0.7,
        autoplay: true,
        autoplayDelay: 8500,
        autoplayDisableOnInteraction: true,
        itemWidth: 0.9.sw,
        itemCount: ofertas.length,
        itemBuilder: (context, i) =>ListaOfertasCard(oferta: ofertas[i]),
      ),
    );
  }
}
