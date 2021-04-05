import 'package:centralApp/api/articulos.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:centralApp/screens/historial/widgets/historial_card_detalles.dart';
import 'package:centralApp/screens/historial/widgets/sin_historial.dart';
import 'package:centralApp/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/articulo_card/widgets/articulo_card_imagen.dart';
import 'package:centralApp/widgets/boton_buscar.dart';
import 'package:centralApp/widgets/boton_carrito.dart';
import 'package:centralApp/widgets/loading_list.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class Historial extends StatelessWidget {
  int idCliente;

  Historial({@required this.idCliente});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    idCliente = arguments['idCliente'];

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Últimas Visitas',
        actions: [
          BotonBuscar(),
          BotonCarrito(),
        ],
      ),
      body: _Body(
        idCliente: idCliente,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int idCliente;
  _Body({this.idCliente});
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  Future<List<Articulo>> futuro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuro = getArticulosHistorial(widget.idCliente);
  }

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
          child: _Lista(futuro: futuro),
        ),
      ],
    );
  }
}

class _Lista extends StatelessWidget {
  final Future<List<Articulo>> futuro;

  _Lista({this.futuro});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articulo>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) return SinConexion();
        if (!snapshot.hasData) return LoadingList(itemsCount: 5);
         if (snapshot.data.length == 0) return SinHistorial();
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return _Item(articulo: snapshot.data[index]);
          },
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final Articulo articulo;

  _Item({this.articulo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': articulo});
      },
      child: Container(
        height: SizeConfig.blockSizeVertical * 13,
        child: _Card(articulo: articulo),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 0.5,
                color: Theme.of(context).accentColor,
                style: BorderStyle.solid),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Articulo articulo;
  _Card({this.articulo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         // Expanded(flex: 1, child: HistorialCardImagen(articulo: articulo)),
          Expanded(flex: 1, child: ArticuloCardImagen(articulo: articulo)),
          Expanded(flex: 2, child: HistorialCardDetalles(articulo: articulo, mostrarDias: true,)),
        ],
      ),
    );
  }
}
