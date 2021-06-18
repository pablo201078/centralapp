import 'package:centralApp/ui/screens/articulo_detalle/widgets/articulo_detalle_galeria.dart';
import 'package:centralApp/ui/screens/carrito/carrito.dart';
import 'package:centralApp/ui/screens/destacados_hogar/destacados_hogar.dart';
import 'package:centralApp/ui/screens/destacados_comercial/destacados_comercial.dart';
import 'package:centralApp/ui/screens/deuda_vencida/deuda_vencida.dart';
import 'package:centralApp/ui/screens/equipamiento_comercial/equipamiento_comercial.dart';
import 'package:centralApp/ui/screens/favoritos/favoritos.dart';
import 'package:centralApp/ui/screens/historial/historial.dart';
import 'package:centralApp/ui/screens/hogar/hogar.dart';
import 'package:centralApp/ui/screens/home/home.dart';
import 'package:centralApp/ui/screens/loggin/login.dart';
import 'package:centralApp/ui/screens/mis_compras/mis_compras.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/mis_compras_detalle.dart';
import 'package:centralApp/ui/screens/pedido_detalle/pedido_detalle.dart';
import 'package:centralApp/ui/screens/pedidos/pedidos.dart';
import 'package:centralApp/ui/screens/search_result/search_result.dart';
import 'package:centralApp/ui/screens/ticket/ticket.dart';
import 'package:centralApp/ui/screens/usados/usados.dart';
import 'package:centralApp/ui/screens/renovacion_efectivo/renovacion_efectivo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/screens/credencial/credencial.dart';
import 'ui/screens/articulo_detalle/articulo_detalle.dart';

getRoutes() {
  return {
    '/': (context) => Home(),
    '/loggin': (context) => Loggin(),
    '/credencial': (context) => Credencial(),
    '/carrito': (context) => Carrito(),
    '/search_result': (context) => SearchResult(),
    '/favoritos': (context) => Favoritos(),
    '/historial': (context) => Historial(),
    '/pedidos': (context) => Pedidos(),
    '/pedido_detalle': (context) => PedidoDetalle(),
    '/hogar': (context) => Hogar(),
    '/equipamiento_comercial': (context) => EquipamientoComercial(),
    '/usados': (context) => Usados(),
    '/deuda_vencida': (context) => DeudaVencida(),
    '/mis_compras': (context) => MisCompras(),
    '/mis_compras_detalle': (context) => MisComprasDetalle(),
    '/destacadosHogar': (context) => DestacadosHogar(),
    '/destacadosComercial': (context) => DestacadosComercial(),
    '/articulo_detalle': (context) => ArticuloDetalle(),
    '/renovacion_efectivo': (context) => RenovacionEfectivo(),
    '/articulo_detalle_galeria': (context) => ArticuloDetalleGaleria(),
    '/ticket': (context) => Ticket(),
  };
}

Route onGenerateRoute(settings) {

  if (settings.name == '/') {
    return MaterialPageRoute(builder: (context) => Home());
  }

  print('generar ruta' + settings.name);

  // Handle '/details/:id'
  var uri = Uri.parse(settings.name);
  if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'articulos') {
    int id = uri.pathSegments[1] as int;
    Get.toNamed(
      '/articulo_detalle',
      arguments: {'idArticulo': id},
    );
    return MaterialPageRoute(builder: (context) => Home());
  }
  return MaterialPageRoute(builder: (context) => Home());
}
