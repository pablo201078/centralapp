import 'package:flutter/material.dart';

class Pedido {
  final int id;
  final int idTipo;
  final String fecha;
  final String fechaAutorizacion;
  final String fechaDesautorizacion;
  final String fechaDescarte;
  final String fechaTransito;
  final String fechaRemito;
  final String fechaEntrega;
  final int idArticulo;
  final String descripcion;
  final String codArticulo;
  final int cantidad;
  final String mensaje;
  //son los mismos campos de pedidoImportado
  final int idEstado; //itemPedido
  final int autorizado; //pedidoimportado

  Pedido(
      {this.id,
      this.idTipo,
      this.idArticulo,
      this.autorizado,
      this.descripcion,
      this.codArticulo,
      this.fecha,
      this.fechaAutorizacion,
      this.fechaDesautorizacion,
      this.fechaDescarte,
      this.fechaTransito,
      this.fechaRemito,
      this.fechaEntrega,
      this.mensaje,
      this.cantidad,
      this.idEstado});

  factory Pedido.fromJson(Map<String, dynamic> jsonData) {
    return Pedido(
      id: int.parse(jsonData['id']),
      idTipo: int.parse(jsonData['idTipo']),
      fecha: jsonData['fecha'] as String,
      fechaAutorizacion: jsonData['fechaAutorizacion'] as String,
      fechaDesautorizacion: jsonData['fechaDesautorizacion'] as String,
      fechaDescarte: jsonData['fechaDescarte'] as String,
      fechaTransito: jsonData['fechaTransito'] as String,
      fechaRemito: jsonData['fechaRemito'] as String,
      fechaEntrega: jsonData['fechaEntrega'] as String,
      descripcion: jsonData['descripcion'] as String,
      codArticulo: jsonData['codArticulo'] as String,
      mensaje: jsonData['mensaje'] as String,
      cantidad: int.parse(jsonData['cantidad']),
      idEstado: int.parse(jsonData['idEstado']),
      autorizado: int.parse(jsonData['autorizado']),
      idArticulo: int.parse(jsonData['idArticulo']),
    );
  }
}

class PedidoEtapa {
  final String fecha;
  final String descripcion;
  final int id;
  final bool actual;
  final bool futuro;
  final Color color;

  PedidoEtapa(
      {this.fecha = '',
      this.id,
      this.descripcion,
      this.color = Colors.black,
      this.actual = false,
      this.futuro = false});

  factory PedidoEtapa.fromJson(Map<String, dynamic> jsonData) {
    Color color = Colors.black;

    if (int.parse(jsonData['id']) == 2) color = Colors.redAccent;
    if (int.parse(jsonData['id']) == 3) color = Colors.green;
    if (int.parse(jsonData['id']) == 4) color = Colors.green;
    if (int.parse(jsonData['id']) == 7) color = Colors.green;//entregado
    if (int.parse(jsonData['id']) == 5) color = Colors.red;
    if (int.parse(jsonData['id']) == 6) color = Colors.black54;

    return PedidoEtapa(
      id: int.parse(jsonData['id']),
      fecha: jsonData['fecha'] as String,
      actual: jsonData['actual'] == '1',
      futuro: jsonData['futuro'] == '1',
      color: color,
      descripcion: jsonData['descripcion'] as String,
    );
  }
}
