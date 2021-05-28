import 'dart:convert';
import 'package:centralApp/data/models/ticket_item.dart';
import 'package:http/http.dart' as http;
import 'package:centralApp/constantes.dart';

class TicketRepository {
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
      throw Exception('Error de conexion');
    }
  }

  Future<bool> getUltimoTicket(int idCliente) async {
    var response = await http.get(
      Uri.parse('${URL}ticket.php?idCliente=$idCliente'),
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<TicketItem> lista = <TicketItem>[];
      for (var item in jsonData) {
        lista.add(TicketItem.fromJson(item));
      }
      if (lista.isEmpty)
        return false;
      else
        return lista[0].hoy ?? false;
    } else {
      throw Exception('Error de conexion');
    }
  }
}
