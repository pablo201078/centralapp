import 'dart:convert';
import 'package:centralApp/models/articulo.dart';
import 'package:http/http.dart' as http;
import '../constantes.dart';
import '../utils.dart';

Future<List<Articulo>> getOfertas(int idCliente) async {
  var id = await getDeviceId();

   var response = await http
       .get('${URL}articulosV2.php?idTipo=1&idCliente=$idCliente&deviceId=$id');
  /*var response = await http.get(
      '${URL}articulos-pruebabanner.php?idTipo=1&idCliente=$idCliente&deviceId=$id');
*/
  if (response.statusCode == 200) {
    // If the server did return a 2 00 OK response,
    // then parse the JSON.

    // Use the compute function to run parsePhotos in a separate isolate.
    // return compute(parseOfertas, response.body);

    var jsonData = json.decode(response.body);
    List<Articulo> lista = List<Articulo>();

    for (var o in jsonData) {
      lista.add(Articulo.fromJson(o));
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
  // });
}
