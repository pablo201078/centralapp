import 'dart:convert';
import 'package:centralApp/models/articulo_categoria.dart';
import 'package:http/http.dart' as http;
import '../constantes.dart';

Future<List<ArticuloCategoria>> getCategorias(int idCliente, int idTipo) async {
  var url =
      Uri.parse('${URL}categorias.php?idTipo=$idTipo&idCliente=$idCliente');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    List<ArticuloCategoria> lista = List<ArticuloCategoria>();

    for (var o in jsonData) lista.add(ArticuloCategoria.fromJson(o));

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
  // });
}
