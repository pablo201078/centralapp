import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constantes.dart';
import '../../notificaciones.dart';

String url_img(int idArticulo, int orden) {
  return 'http://amacar.com.ar/images/cache/product-page/articulo-{$idArticulo}_$orden.png';
}

Future<bool> postFavorito(
    Articulo articulo, int idCliente, bool favorito, BuildContext ctx) async {
  var client = http.Client();

  int timeout = 3;
  try {
    var url = Uri.parse(URL + 'postFavorito.php');
    http.Response response = await client.post(url, body: {
      'idCliente': idCliente.toString(),
      'idArticulo': articulo.idArticulo.toString(),
      'favorito': favorito.toString()
    }).timeout(Duration(seconds: timeout));

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

Future<List<Articulo>> getCarrito(int idCliente) async {
  var client = http.Client();
  List<Articulo> lista = <Articulo>[];
  int timeout = 3;
  try {
    var url = Uri.parse('${URL}articulosV2.php?idTipo=2&idCliente=$idCliente');
    http.Response response =
        await client.get(url).timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Articulo art;
      for (var o in jsonData) {
        art = Articulo.fromJson(o);
        lista.add(art);
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

Future<bool> actualizarCarrito(
    Articulo articulo, int idCliente, bool enCarrito, BuildContext ctx) async {
  var client = http.Client();
  int timeout = 5;
  try {
    var url = Uri.parse(URL + 'postCarrito.php');
    http.Response response = await client.post(url, body: {
      'idCliente': idCliente.toString(),
      'idArticulo': articulo.idArticulo.toString(),
      'cc': articulo.plan.toString(),
      'cantidad': articulo.getCantidad.toString(),
      'usado': articulo.usado ? '1' : '0',
      'enCarrito': enCarrito.toString(),
      'idAtributo': articulo.atributo.idAtributo.toString(),
    }).timeout(Duration(seconds: timeout));

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

Future<bool> comprarCarrito(int idCliente, BuildContext ctx) async {
  var client = http.Client();
  int timeout = 8;
  try {
    var url = Uri.parse(URL + 'comprarCarrito.php');
    http.Response response = await client.post(url, body: {
      'idCliente': idCliente.toString(),
    }).timeout(Duration(seconds: timeout));

    print(response.body.toString());

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

Future<List<Articulo>> getSearch(int idCliente, String searchQuery) async {
  var url = Uri.parse(
      '${URL}articulosV2.php?idTipo=4&idCliente=$idCliente&searchQuery=$searchQuery');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<Articulo> lista = <Articulo>[];
    var jsonData = json.decode(response.body);
    Articulo art;
    for (var o in jsonData) {
      art = Articulo.fromJson(o);
      lista.add(art);
      //  print( o );
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<List<Articulo>> getFavoritos(int idCliente) async {
  var client = http.Client();
  List<Articulo> lista = <Articulo>[];
  int timeout = 2;
  try {
    var url = Uri.parse('${URL}articulosV2.php?idTipo=3&idCliente=$idCliente');
    http.Response response =
        await client.get(url).timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Articulo art;
      for (var o in jsonData) {
        art = Articulo.fromJson(o);
        lista.add(art);
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

Future<List<Articulo>> getDestacados(int idCliente, int idTipo) async {
  var url =
      Uri.parse('${URL}articulosV2.php?idTipo=$idTipo&idCliente=$idCliente');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Articulo> lista = <Articulo>[];
    var jsonData = json.decode(response.body);
    Articulo art;
    for (var o in jsonData) {
      art = Articulo.fromJson(o);
      lista.add(art);
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<List<Articulo>> getArticulosPorCategoria(
    int idCliente, int idTipo, int idCategoria) async {
  var url = Uri.parse(
      '${URL}articulosV2.php?idTipo=$idTipo&idCliente=$idCliente&idCategoria=$idCategoria');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Articulo> lista = <Articulo>[];
    var jsonData = json.decode(response.body);
    Articulo art;
    for (var o in jsonData) {
      art = Articulo.fromJson(o);
      lista.add(art);
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<bool> postHistorial(int idCliente, int idArticulo) async {
  var client = http.Client();
  int timeout = 10;
  try {
    var url = Uri.parse(URL + 'postHistorial.php');
    http.Response response = await client.post(url, body: {
      'idCliente': idCliente.toString(),
      'idArticulo': idArticulo.toString(),
    }).timeout(Duration(seconds: timeout));

    return (response.statusCode == 200);
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    return false;
  } on SocketException catch (e) {
    print('Socket Error: $e');
    return false;
  } on Error catch (e) {
    print('General Error: $e');
    return false;
  }
}

Future<List<Articulo>> getArticulosHistorial(int idCliente) async {
  var url = Uri.parse('${URL}articulosV2.php?idTipo=10&idCliente=$idCliente');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Articulo> lista = <Articulo>[];
    var jsonData = json.decode(response.body);
    Articulo art;
    for (var o in jsonData) {
      art = Articulo.fromJson(o);
      lista.add(art);
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<List<Articulo>> getUsados(int idCliente) async {
  var url = Uri.parse('${URL}articulosV2.php?idTipo=11&idCliente=$idCliente');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Articulo> lista = <Articulo>[];
    var jsonData = json.decode(response.body);
    Articulo art;
    for (var o in jsonData) {
      art = Articulo.fromJson(o);
      // print(art.descripcion);
      lista.add(art);
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<Articulo> getArticulo(int idCliente, int idTipo, int idArticulo) async {
  var url = Uri.parse(
      '${URL}articulosV2.php?idTipo=$idTipo&idCliente=$idCliente&idArticulo=$idArticulo');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    Articulo art;
    for (var o in jsonData) {
      art = Articulo.fromJson(o);
    }

    return art;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}
