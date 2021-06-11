import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/articulo_card/widgets/articulo_card_imagen_id.dart';
import 'package:centralApp/ui/widgets/boton_buscar.dart';
import 'package:centralApp/ui/widgets/boton_carrito.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:centralApp/utils.dart';

class DestacadosHogar extends StatelessWidget {
  List<Articulo> lista;

  DestacadosHogar({Key key, @required this.lista});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.lista = arguments['lista'];

    return Scaffold(
      appBar: buildAppBar(context,
          title: 'Para tu Hogar', actions: [BotonBuscar(), BotonCarrito()]),
      body: _Body(
        lista: lista,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<Articulo> lista;

  _Body({@required this.lista});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(lista.length, (index) {
              return _Card(
                articulo: lista[index],
                index: index,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Articulo articulo;
  final int index;
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

  _Card({Key key, @required this.articulo, @required this.index});

  @override
  Widget build(BuildContext context) {
    String plan;
    if (articulo.en250 != 0) {
      plan =
          'Pagas por Día  ${articulo.oferta ? formatCurrency.format(articulo.en250bon) : formatCurrency.format(articulo.en250)}';
    } else
      plan =
          'Pagas por Día  ${articulo.oferta ? formatCurrency.format(articulo.en200bon) : formatCurrency.format(articulo.en200)}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': articulo});
      },
      child: Container(

        width: SizeConfig.safeBlockHorizontal * 37,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                width: 0.3,
                color: Theme.of(context).accentColor,
                style: !index.isEven ? BorderStyle.solid : BorderStyle.none),
            top: BorderSide(
                width: index < 2 ? 0.3 : 0.15,
                color: Theme.of(context).accentColor,
                style: BorderStyle.solid),
            bottom: BorderSide(
                width: 0.3,
                color: Theme.of(context).accentColor,
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
              child: ArticuloCardImagenId(
                idArticulo: articulo.idArticulo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                articulo.descripcion,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Text(
              plan,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
