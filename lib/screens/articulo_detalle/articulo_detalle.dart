import 'package:centralApp/api/articulos.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:centralApp/models/scoped/carrito.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_atributos.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_banner_usado.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_cantidad.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_caracteristicas.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_caracteristicas_tabla.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_descripcion.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_imagenes.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/articulo_planes.dart';
import 'package:centralApp/screens/articulo_detalle/widgets/boton_agregar_al_carrito.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/boton_buscar.dart';
import 'package:centralApp/widgets/boton_carrito.dart';
import 'package:centralApp/widgets/boton_like.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ArticuloDetalle extends StatelessWidget {
  Articulo articulo;
  int idArticulo;

  ArticuloDetalle({Key key, this.articulo, this.idArticulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.articulo = arguments['articulo'];
    this.idArticulo = arguments['idArticulo'];

    //si no recibo el articulo, entonces recibo el id y tengo q descargarlo
    return this.articulo != null
        ? _Scaffold(
            articulo: this.articulo,
            agregarAlCarrito: true,
          )
        : _Futuro(
            idArticulo: this.idArticulo,
          );
  }
}

class _Futuro extends StatelessWidget {
  final int idArticulo;
  _Futuro({this.idArticulo});
  @override
  Widget build(BuildContext context) {
    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return FutureBuilder<Articulo>(
      future: getArticulo(loggedModel.getUser.idCliente, 9, this.idArticulo),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? _Scaffold(
                articulo: snapshot.data,
                agregarAlCarrito: false,
              )
            : Center(
                child: Container(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator()));
      },
    );
  }
}

class _Scaffold extends StatelessWidget {
  final Articulo articulo;
  final bool agregarAlCarrito;

  _Scaffold({this.articulo, this.agregarAlCarrito});

  List<Widget> _buildActions() {
    return <Widget>[
      Visibility(
        visible: !this.articulo.usado,
        child: BotonLike(
          articulo: this.articulo,
          color: Colors.white,
        ),
      ),
      BotonBuscar(),
      BotonCarrito()
    ];
  }

  @override
  Widget build(BuildContext context) {
    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    if (loggedModel.isLogged) {
      postHistorial(loggedModel.getUser.idCliente, this.articulo.idArticulo);
    }

    return Scaffold(
      appBar: buildAppBar(context,  title: 'Producto', actions: _buildActions()),
      body: _ScrollView(articulo: articulo, botonCarrito: agregarAlCarrito),
    );
  }
}

class _ScrollView extends StatelessWidget {
  const _ScrollView(
      {Key key, @required this.articulo, this.botonCarrito = true})
      : super(key: key);

  final Articulo articulo;
  final bool botonCarrito;

  @override
  Widget build(BuildContext context) {
    final CarritoModel carrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: false);

    if (!carrito.existe(articulo)) articulo.cantidad = 1;

    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        ArticuloDescripcion(articulo: articulo),
        Visibility(
          visible: articulo.usado,
          child: ArticuloBannerUsado(),
        ),
        ArticuloImagenes(articulo: articulo),
        SizedBox(height: 20.0),
        ArticuloCantidad(articulo: articulo),
        SizedBox(height: 10.0),
        ArticuloPlanes(articulo: articulo),
        SizedBox(height: 10.0),
        Divider(
          thickness: 1.3,
          endIndent: 20,
          indent: 20,
        ),
        ArticuloCaracteristicas(articulo: articulo),
        Visibility(
            visible: articulo.caracteristicas.isNotEmpty,
            child: ArticuloCaracteristicasTabla(articulo: articulo)),
        Visibility(
            visible: articulo.tieneAtributo,
            child: ArticuloAtributos(articulo: articulo)),
        Divider(
          thickness: 1.3,
          endIndent: 20,
          indent: 20,
        ),
        SizedBox(height: 10.0),
        Visibility(
            visible: botonCarrito,
            child: BotonAgregarAlCarrito(articulo: this.articulo)),
      ],
    );
  }
}
