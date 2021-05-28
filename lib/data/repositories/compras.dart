import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:centralApp/data/models/credito.dart';
import 'package:http/http.dart' as http;
import 'package:centralApp/constantes.dart';

class ComprasRepository {
  Future<List<Credito>> getCreditos(int idCliente) async {
    var url = Uri.parse('${URL}compras.php?idCliente=$idCliente');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Credito> lista = List<Credito>();
      for (var item in jsonData) {
        lista.add(Credito.fromJson(item));
      }

      return lista;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Error de conexion');
    }
  }

  Future<Credito> getCredito(int idCliente, int idCredito) async {
    var url = Uri.parse(
        '${URL}compras.php?idCredito=$idCredito&idCliente=$idCliente');
    var response = await http
        .get('${URL}compras.php?idCredito=$idCredito&idCliente=$idCliente');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Credito> lista = List<Credito>();
      for (var item in jsonData) {
        lista.add(Credito.fromJson(item));
      }

      return lista[0];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Error de conexion');
    }
  }

  Future<List<Pago>> getPagos(int idCredito) async {
    var url = Uri.parse('${URL}historial_pago.php?idCredito=$idCredito');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Pago> lista = List<Pago>();
      for (var item in jsonData) {
        lista.add(Pago.fromJson(item));
      }

      return lista;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Error de conexion');
    }
  }

  Future<List<Deuda>> getDeuda(int idCredito) async {
    var url = Uri.parse('${URL}cuotasAdeudadas.php?idCredito=$idCredito');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Deuda> lista = List<Deuda>();
      for (var item in jsonData) {
        lista.add(Deuda.fromJson(item));
      }

      return lista;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Error de conexion');
    }
  }

  Future<List<Credito>> getCreditosDeuda(int idCliente) async {
    var client = http.Client();
    List<Credito> lista = List<Credito>();
    int timeout = 5;
    try {
      var url = Uri.parse('${URL}compras.php?idCliente=$idCliente&soloDeuda=1');
      http.Response response =
          await client.get(url).timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        Credito art;
        for (var o in jsonData) {
          art = Credito.fromJson(o);
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

  Future<int> getCreditosDeudaContador(int idCliente) async {
    var client = http.Client();
    List<Credito> lista = List<Credito>();
    int timeout = 2;
    try {
      var url = Uri.parse('${URL}compras.php?idCliente=$idCliente&soloDeuda=1');
      http.Response response =
          await client.get(url).timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        Credito art;
        for (var o in jsonData) {
          art = Credito.fromJson(o);
          lista.add(art);
        }

        return lista.length;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      return 0;
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return 0;
    } on Error catch (e) {
      print('General Error: $e');
      return 0;
    }
  }
}
