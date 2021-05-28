import 'package:centralApp/data/api/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/data/scoped/carrito.dart';
import 'package:centralApp/data/scoped/logged_model.dart';
import 'package:centralApp/data/scoped/pedidos.dart';
import 'package:centralApp/screens/carrito/widgets/articulo_card.dart';
import 'package:centralApp/screens/carrito/widgets/boton_comprar.dart';
import 'package:centralApp/screens/carrito/widgets/boton_seguir_comprando.dart';
import 'package:centralApp/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../utils.dart';

class Carrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(context, title: 'Mi Carrito', actions: []),
      body: CarritoBody(),
    );
  }
}

class CarritoBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: SizeConfig.safeBlockVertical * 60,
              child: CarritoArticulos(),
            ),
          ),
          TotalCarrito(),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          BotonesCarrito(),
        ],
      ),
    );
  }
}

class TotalCarrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CarritoModel carrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: true);

    return Visibility(
      visible: carrito.articulos.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, bottom: 10, top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Envío a domicilio sin costo',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: SizeConfig.safeBlockHorizontal * 4.0),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pagas por Día:',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatearNumero(carrito.total),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BotonesCarrito extends StatelessWidget {
  BotonesCarrito({Key key});

  @override
  Widget build(BuildContext context) {
    CarritoModel carrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BotonSeguirComprando(
          ancho: carrito.articulos.isEmpty ? 75 : 30,
        ),
        Visibility(
          visible: carrito.articulos.isNotEmpty,
          //el boton comprar tiene el pedidosModel, porq despues de hacer la compra. Tengo que actualizar los pedidos para el contador de pedidos del menu
          child: ScopedModel<PedidosModel>(
            model: PedidosModel(),
            child: BotonComprar(),
          ),
        ),
      ],
    );
  }
}

class CarritoArticulos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);
    CarritoModel carrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: false);

    return FutureBuilder<List<Articulo>>(
      future: getCarrito(loggedModel.getUser.idCliente),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return SinConexion();
        }

        if (!snapshot.hasData)
          return LoadingList(
            itemsCount: carrito.articulos.length,
          );

        if (snapshot.data.isEmpty)
          return _CarritoVacio();
        else {
          carrito.articulos = snapshot.data;
          return _ListadoCarrito();
        }
      },
    );
  }
}

class _ListadoCarrito extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    CarritoModel carrito =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: false);

    return carrito.articulos.isEmpty
        ? _CarritoVacio()
        : AnimatedList(
            key: _listKey,
            initialItemCount: carrito.articulos.length,
            itemBuilder: (context, index, animation) {
              return FadeTransition(
                opacity: animation,
                child: ArticuloCard(
                  index: index,
                  articulo: carrito.articuloIndex(index),
                  listKey: _listKey,
                ),
              );
            });
  }
}

class _CarritoVacio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.remove_shopping_cart, size: 60, color: Colors.red),
          Text(
            'El Carrito está Vacio',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: SizeConfig.safeBlockHorizontal * 7),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
