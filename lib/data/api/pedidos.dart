import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:centralApp/data/models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constantes.dart';
import '../../notificaciones.dart';

Future<Pedido> getPedido(int idPedido) async {
  var client = http.Client();
  Pedido pedido;

  int timeout = 4;
  try {
    http.Response response = await client
        .get(
          Uri.parse('${URL}pedidosV2.php?idPedido=$idPedido'),
        )
        .timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var item in jsonData) {
        pedido = Pedido.fromJson(item);
      }

      return pedido;
    }
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    return pedido;
  } on SocketException catch (e) {
    print('Socket Error: $e');
    return pedido;
  } on Error catch (e) {
    print('General Error: $e');
    return pedido;
  }
}

Future<List<Pedido>> getPedidos(int idCliente) async {
  var client = http.Client();
  List<Pedido> lista = List<Pedido>();
  int timeout = 3;
  try {
    http.Response response = await client
        .get(
          Uri.parse('${URL}pedidosV2.php?idCliente=$idCliente'),
        )
        .timeout(Duration(seconds: timeout));

    print('${URL}pedidosV2.php?idCliente=$idCliente');
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Pedido> lista = List<Pedido>();
      for (var item in jsonData) {
        lista.add(Pedido.fromJson(item));
      }

      return lista;
    }
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    return lista;
  } on SocketException catch (e) {
    print('Socket Error: $e');
    return lista;
  } on Error catch (e) {
    print('General Error: $e');
    return lista;
  }
}

Future<List<PedidoEtapa>> getPedidoEtapas(int idPim) async {
  var response = await http.get(
    Uri.parse('${URL}pedido_etapas.php?idPim=$idPim'),
  );

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    List<PedidoEtapa> lista = List<PedidoEtapa>();
    for (var item in jsonData) {
      lista.add(PedidoEtapa.fromJson(item));
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<bool> anularPedido(int id, BuildContext ctx) async {
  int timeout = 10;
  try {
    http.Response response =
        await http.post(Uri.parse('${URL}anularPedido.php'), body: {
      'id': id.toString(),
    }).timeout(Duration(seconds: timeout));
    print(response.body);
    return (response.statusCode == 200);
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    showSnackBar(ctx, 'Oops, algo salio mal.', Colors.red);
    return false;
  } on SocketException catch (e) {
    print('Socket Error: $e');
    showSnackBar(ctx, 'Oops, algo salio mal.', Colors.red);
    return false;
  } on Error catch (e) {
    print('General Error: $e');
    showSnackBar(ctx, 'Oops, algo salio mal.', Colors.red);
    return false;
  }
}