import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
}
