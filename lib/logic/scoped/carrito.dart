import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/repositories/pedidos.dart';
import 'package:centralApp/logic/scoped/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/notificaciones.dart';
import 'logged_model.dart';

class CarritoModel extends Model {
  List<Articulo> _carrito = <Articulo>[];
  bool _cargando = false;

  static CarritoModel of(BuildContext context) =>
      ScopedModel.of<CarritoModel>(context);

  set articulos(lista) {
    _carrito = lista;
    notifyListeners();
  }

  int get cantidad {
    return _carrito.length;
  }

  set cargando(value) {
    _cargando = value;
    notifyListeners();
  }

  bool get cargando {
    return _cargando;
  }

  double get total {
    double total = 0;
    _carrito.forEach((element) {
      total += element.cantidad * element.planActual;
    });

    return total;
  }

  List<Articulo> get articulos {
    return _carrito;
  }

  Articulo articuloIndex(int index) {
    return _carrito[index];
  }

  void agregar(Articulo articulo) {
    var contain =
        _carrito.where((element) => element.idArticulo == articulo.idArticulo);
    if (contain.isEmpty) {
      this._carrito.add(articulo);
    }
    notifyListeners();
  }

  void eliminar(Articulo articulo) {
    _carrito
        .removeWhere((element) => element.idArticulo == articulo.idArticulo);
    articulo.cantidad = 1;
    articulo.atributo = articulo.atributos.first;
    notifyListeners();
  }

  void vaciar() {
    _carrito.clear();
    notifyListeners();
  }

  bool existe(Articulo articulo) {
    var contain = this
        ._carrito
        .where((element) => element.idArticulo == articulo.idArticulo);
    return !contain.isEmpty;
  }

  void agregarAlCarrito(BuildContext context, Articulo articulo) async {
    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);
    var articuloRepository = ArticuloRepository();
    if (this.cargando) return;

    if (articulo.atributo.idAtributo == 0 && articulo.tieneAtributo) {
      showMessage(
          context, 'Tenés que elegir de que tipo es.', DialogType.WARNING);
      return;
    }

    this.cargando = true;

    bool rta = await articuloRepository.actualizarCarrito(
        articulo, loggedModel.getUser.idCliente, true);

    this.cargando = false;

    if (rta) {
      this.agregar(articulo);
      Navigator.pushNamed(context, '/carrito');
    } else
      showSnackBar(context, 'Oops, algo salio mal.', Colors.red);
  }

  void comprarCarrito(BuildContext context) async {
    if (cargando) return;
    cargando = true;
    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);
    final PedidosModel pedidosModel =
        ScopedModel.of<PedidosModel>(context, rebuildOnChange: false);

    var articuloRepository = ArticuloRepository();
    bool rta =
        await articuloRepository.comprarCarrito(loggedModel.getUser.idCliente);
    pedidosModel.pedidos = await getPedidos(loggedModel.getUser.idCliente);
    cargando = false;

    if (rta) {
      VoidCallback ok = () async {
        vaciar();
        Navigator.popUntil(context, ModalRoute.withName('/'));
      };
      showFinCompra(context, ok);
    } else
      showSnackBar(context, 'Algo salio mal', Colors.redAccent);
  }
}
