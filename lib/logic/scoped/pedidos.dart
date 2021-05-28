import 'package:centralApp/data/models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PedidosModel extends Model {
  List<Pedido> _pedidos = <Pedido>[];

  PedidosModel._privateConstructor();
  static final PedidosModel _instance = PedidosModel._privateConstructor();

  factory PedidosModel() {
    return _instance;
  }

  static PedidosModel of(BuildContext context) =>
      ScopedModel.of<PedidosModel>(context);

  set pedidos(lista) {
    _pedidos = lista;
    notifyListeners();
  }

  List<Pedido> get pedidos {
    return _pedidos;
  }

  int get pedidosCantidad => _pedidos.length;

  void eliminar(Pedido pedido) {
    _pedidos.removeWhere((element) => element.id == pedido.id);
    notifyListeners();
  }
}
