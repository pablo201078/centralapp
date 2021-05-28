import 'package:auto_size_text/auto_size_text.dart';
import 'package:centralApp/widgets/articulo_card/widgets/articulo_card_imagen_id.dart';
import 'package:centralApp/data/api/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/data/scoped/logged_model.dart';
import 'package:centralApp/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/boton_buscar.dart';
import 'package:centralApp/widgets/boton_carrito.dart';
import 'package:centralApp/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../utils.dart';

class DestacadosComercial extends StatelessWidget {
  int idCliente;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.idCliente = arguments['idCliente'];

    return DestacadosComercialHome(
      idCliente: this.idCliente,
    );
  }
}

class DestacadosComercialHome extends StatefulWidget {
  final int idCliente;

  DestacadosComercialHome({Key key, @required this.idCliente});

  @override
  _DestacadosComercialHomeState createState() =>
      _DestacadosComercialHomeState();
}

class _DestacadosComercialHomeState extends State<DestacadosComercialHome> {
  Future<List<Articulo>> _future;

  @override
  void initState() {
    // TODO: implement initState
    _future = getDestacados(widget.idCliente, 12);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String txt = 'Para tu Comercio';

    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    if (model.isLogged) txt = 'Para  ${model.getUser.rubro ?? 'Comercio'}';

    return Scaffold(
      appBar: buildAppBar(context,
          title: txt, actions: [BotonBuscar(), BotonCarrito()]),
      body: FutureBuilder<List<Articulo>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) return SinConexion();
          if (!snapshot.hasData) return LoadingList(itemsCount: 10);
          return _Body(
            lista: snapshot.data,
            idCliente: model.getUser.idCliente,
          );
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final List<Articulo> lista;
  final int idCliente;

  _Body({@required this.lista, @required this.idCliente});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
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
            children: List.generate(widget.lista.length, (index) {
              return _Card(
                articulo: widget.lista[index],
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
          'Pagas por Día  ${articulo.oferta ? formatearNumero(articulo.en250bon) : formatearNumero(articulo.en250)}';
    } else
      plan =
          'Pagas por Día  ${articulo.oferta ? formatearNumero(articulo.en200bon) : formatearNumero(articulo.en200)}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': articulo});
      },
      child: Container(
        //  height: 250,
        width: SizeConfig.safeBlockHorizontal * 37,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
                width: 0.3,
                color: Theme.of(context).accentColor,
                style: index.isEven ? BorderStyle.solid : BorderStyle.none),
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
              child: AutoSizeText(
                articulo.descripcion,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 2),
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            Text(
              plan,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 3.0,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
