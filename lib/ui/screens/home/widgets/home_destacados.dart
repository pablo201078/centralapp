import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:centralApp/ui/widgets/articulo_card/widgets/articulo_card_imagen_loading.dart';
import 'package:centralApp/ui/widgets/elevated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:centralApp/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDestacados extends StatelessWidget {
  final Future<List<Articulo>> futuro;

  HomeDestacados({
    @required this.futuro,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articulo>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (!snapshot.hasData)
          return _Cargando(); //CircularProgressIndicator();
        return _CajaDestacados(lista: snapshot.data);
      },
    );
  }
}

class _Cargando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.8.sh,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 12,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 12,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CajaDestacados extends StatelessWidget {
  final List<Articulo> lista;

  _CajaDestacados({
    @required this.lista,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      shadowColor: Theme.of(context).primaryColor,
      height: 0.90.sh, //700,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      child: Column(
        children: [
          _Encabezado(),
          Expanded(
            child: Column(
              children: [
                _fila(lista, 0, 1),
                _fila(lista, 2, 3),
                _fila(lista, 4, 5),
              ],
            ),
          ),
          _Footer(lista: lista),
        ],
      ),
    );
  }
}

Row _fila(List<Articulo> lista, int i, j) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: _Card(
          articulo: lista[i],
          index: i,
        ),
      ),
      Expanded(
        child: _Card(
          articulo: lista[j],
          index: j,
        ),
      )
    ],
  );
}

class _Card extends StatelessWidget {
  final Articulo articulo;
  final int index;
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

  _Card({Key key, @required this.articulo, @required this.index});
  var articuloRepository = ArticuloRepository();

  @override
  Widget build(BuildContext context) {
    String plan;
    if (articulo.en250 != 0) {
      plan =
          'Pagas por D??a  ${articulo.oferta ? formatearNumero(articulo.en250bon) : formatearNumero(articulo.en250)}';
    } else
      plan =
          'Pagas por D??a  ${articulo.oferta ? formatearNumero(articulo.en200bon) : formatearNumero(articulo.en200)}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': articulo});
      },
      child: Container(
        height: 0.26.sh, //200,
        width: 0.37.sw,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                width: 0.3,
                color: Theme.of(context).primaryColor,
                style: !index.isEven ? BorderStyle.solid : BorderStyle.none),
            bottom: BorderSide(
                width: 0.3,
                color: Theme.of(context).primaryColor,
                style: BorderStyle.solid),
          ),
        ),
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'articulo-${articulo.idArticulo}',
              child: Image(
                height: 0.18.sh,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: ArticuloCardImagenLoading(),
                  );
                },
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(
                  articuloRepository.url_img(articulo.idArticulo, 0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                articulo.descripcion,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Text(
              plan,
              style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  final String titulo = 'Destacados Comerciales';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      height: 0.06.sh,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.4,
            color: Theme.of(context).primaryColor,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Text(
        titulo,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final List<Articulo> lista;

  _Footer({@required this.lista});

  @override
  Widget build(BuildContext context) {
    final UsuarioBloc model =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: true);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        onTap: model.isLogged
            ? () {
                Navigator.pushNamed(context, '/destacadosComercial',
                    arguments: {'idCliente': model.getUser.idCliente});
              }
            : null,
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20),
          height: 0.06.sh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  model.isLogged
                      ? 'Ver Productos de ${model.getUser.rubro} '
                      : '',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.blueAccent)
            ],
          ),
        ),
        //SizeConfig.safeBlockVertical * 7.0,
      ),
    );
  }
}
