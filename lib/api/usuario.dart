import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:centralApp/models/usuario.dart';
import 'package:centralApp/one_signal.dart';
import 'package:http/http.dart' as http;
import 'package:centralApp/constantes.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import '../utils.dart';

Future<Usuario> getUsuario(
    String codigo, bool validarDispositivo, int idTipo) async {
  var id = await getDeviceId();

  final response = await http.post(Uri.parse(URL + 'loginV2.php'), body: {
    'tipoLogin': '1', //scan
    'pdf417': codigo,
    'deviceId': id,
    'idTipo': idTipo.toString(),
    'validarDispositivo': validarDispositivo ? '1' : '0',
  });

  if (response.statusCode == 200) {
    // If the server did return a 2 00 OK response,
    // then parse the JSON.
    return Usuario.fromJson(
      json.decode(response.body),
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<Usuario> getUsuarioClave(
    String dni, String clave, bool validarDispositivo, int idTipo) async {
  var id = await getDeviceId();
  final response = await http.post(Uri.parse(URL + 'loginV2.php'), body: {
    'tipoLogin': '2', //dni  clave
    'clave': clave,
    'dni': dni,
    'deviceId': id,
    'idTipo': idTipo.toString(),
    'validarDispositivo': validarDispositivo ? '1' : '0',
  });

  if (response.statusCode == 200) {
    // If the server did return a 2 00 OK response,
    // then parse the JSON.
    return Usuario.fromJson(
      json.decode(response.body),
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
}

Future<List<String>> getBusquedas(int idCliente) async {
  var client = http.Client();
  List<String> lista = List<String>();
  int timeout = 2;
  try {
    http.Response response = await client
        .get(Uri.parse('${URL}busquedasAnteriores.php?idCliente=${idCliente}'))
        .timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var o in jsonData) {
        lista.add(o);
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

Future<String> getQr(LoggedModel loggedModel, int idCliente) async {
  var client = http.Client();

  int timeout = 3;
  try {
    http.Response response = await client
        .get(
          Uri.parse('${URL}getQrV3.php?idCliente=${idCliente}'),
        )
        .timeout(
          Duration(seconds: timeout),
        );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      loggedModel.actualizarDatos(
        jsonData['qr'] ?? '',
        jsonData['fecha'] ?? '',
        jsonData['cierraSesion'] ?? '',
        jsonData['nroSocio'] ?? '',
        jsonData['rubro'] ?? '',
      );

      abrirSesionOneSignal(idCliente, jsonData['hash']);

      return jsonData['qr'];
    }
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    return '';
  } on SocketException catch (e) {
    print('Socket Error: $e');
    return '';
  } on Error catch (e) {
    print('General Error: $e');
    return '';
  }
}

Future<int> checkQr(LoggedModel loggedModel) async {
  var client = http.Client();
  //aca chequeo si el QR que tengo en la App es el mismo que el del servidor:
  //1 - si es el mismo devuelvo 1
  //2 - si son distintos devuelvo lo actualizo y devuelvo 2
  //3 - si tengo error de conexion devuelvo 0
  int timeout = 5;
  try {
    http.Response response = await client
        .get(
          Uri.parse(
              '${URL}getQrV2.php?idCliente=${loggedModel.getUser.idCliente}'),
        )
        .timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['qr'] != loggedModel.getUser.qrCode) {
        loggedModel.actualizarQr(jsonData['qr'], jsonData['fecha']);
        return 2;
      } else
        return 1;
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

  return 0;
}

Future<bool> checkLogin(int idCliente) async {
  var client = http.Client();
  var id = await getDeviceId();
  int timeout = 3;
  try {
    http.Response response = await client
        .get(
          Uri.parse('${URL}checkLogin.php?idCliente=$idCliente&deviceId=$id'),
        )
        .timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) return response.body.trim() != '0';
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    return true;
  } on SocketException catch (e) {
    print('Socket Error: $e');
    return true;
  } on Error catch (e) {
    print('General Error: $e');
    return true;
  }
}

Future<bool> postRenovacionEfectivo(int idCliente, DateTime fecha) async {
  var client = http.Client();

  int timeout = 3;
  try {
    http.Response response = await client.post(
      Uri.parse('${URL}postRenovarEfectivoV2.php'),
      body: {
        'idCliente': idCliente.toString(),
        'fecha': fecha.toString(),
      },
    ).timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      return response.body.trim() == '1';
    }
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

Future<bool> postContactarAsesor(int idCliente) async {
  var client = http.Client();

  int timeout = 2;

  print('${URL}contactarAsesor.php?idCliente=$idCliente');

  try {
    http.Response response = await client
        .get(
          Uri.parse('${URL}contactarAsesor.php?idCliente=$idCliente'),
        )
        .timeout(Duration(seconds: timeout));

    if (response.statusCode == 200) {
      return response.body.trim() == '1';
    }
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    return true;
  } on SocketException catch (e) {
    print('Socket Error: $e');
    return true;
  } on Error catch (e) {
    print('General Error: $e');
    return true;
  }
}

Future<Vencimiento> checkVencimiento(int idCliente) async {
  var client = http.Client();
  Vencimiento vencimiento = Vencimiento();
  int timeout = 3;
  try {
    http.Response response = await client
        .get(
          Uri.parse('${URL}checkVencimiento.php?idCliente=$idCliente'),
        )
        .timeout(Duration(seconds: timeout));

    print('${URL}checkVencimiento.php?idCliente=$idCliente');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      vencimiento = Vencimiento.fromJson(jsonData);
      return vencimiento;
    }
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
    return vencimiento;
  } on SocketException catch (e) {
    print('Socket Error: $e');
    return vencimiento;
  } on Error catch (e) {
    print('General Error: $e');
    return vencimiento;
  }
}

Future<bool> postImagen(
    String fileName, String base64Image, int idCliente) async {
  final response = await http.post(Uri.parse('${URL}postImagen.php'),
      // headers: {"Content-Type": "multipart/form-data"},
      encoding: Encoding.getByName("utf-8"),
      body: {
        "image": base64Image,
        "name": fileName,
        "idCliente": idCliente.toString(),
      });
  print(response.body);
  return (response.statusCode == 200);
}

Future<bool> postCompartirQr(int idCliente) async {
  var client = http.Client();

  int timeout = 3;
  try {
    http.Response response = await client.post(
      Uri.parse('${URL}postCompartirQr.php'),
      body: {
        'idCliente': idCliente.toString(),
      },
    ).timeout(Duration(seconds: timeout));

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
