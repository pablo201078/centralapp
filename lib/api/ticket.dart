import 'dart:convert';
import 'package:centralApp/models/ticket_item.dart';
import 'package:http/http.dart' as http;
import '../constantes.dart';

Future<List<TicketItem>> getTicket(int idCliente) async {
  var response = await http.get(
    Uri.parse('${URL}ticketV2.php?idCliente=$idCliente'),
  );

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    List<TicketItem> lista = List<TicketItem>();
    for (var item in jsonData) {
      lista.add(
        TicketItem.fromJson(item),
      );
    }

    return lista;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
  // });
}

Future<bool> getUltimoTicket(int idCliente) async {
  var response = await http.get(
    Uri.parse('${URL}ticket.php?idCliente=$idCliente'),
  );

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    List<TicketItem> lista = List<TicketItem>();
    for (var item in jsonData) {
      lista.add(TicketItem.fromJson(item));
    }
    if (lista.isEmpty)
      return false;
    else
      return lista[0].hoy ?? false;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error de conexion');
  }
  // });
}
