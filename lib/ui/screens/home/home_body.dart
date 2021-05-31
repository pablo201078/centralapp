import 'dart:async';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/repositories/ofertas.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/pedidos.dart';
import 'package:centralApp/ui/screens/home/widgets/accesos_directos.dart';
import 'package:centralApp/ui/screens/home/widgets/boton_login.dart';
import 'package:centralApp/ui/screens/home/widgets/boton_whatsapp.dart';
import 'package:centralApp/ui/screens/home/widgets/home_destacados.dart';
import 'package:centralApp/ui/screens/home/widgets/home_destacados_hogar.dart';
import 'package:centralApp/ui/screens/home/widgets/lista_ofertas.dart';
import 'package:check_app_version/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/constantes.dart';

class HomeBody extends StatefulWidget {
  final int idCliente;
  HomeBody({@required this.idCliente});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeBodyMain();
  }
}

class _HomeBodyMain extends State<HomeBody> {
  Future<List<Articulo>> _ofertas;
  Future<List<Articulo>> _destacadosHogar;
  Future<List<Articulo>> _destacadosComercial;
  var articuloRepository = ArticuloRepository();
  var ofertasRepo = OfertasRepository();

  @override
  void initState() {
    super.initState();
    if (widget.idCliente != 0) {
      PedidoBloc pedidoBloc = PedidoBloc();
      pedidoBloc.comprobarVencimiento(context, widget.idCliente);
    }

    _ofertas = ofertasRepo.getOfertas(widget.idCliente);
    _destacadosHogar = articuloRepository.getDestacados(widget.idCliente, 5);
    _destacadosComercial =
        articuloRepository.getDestacados(widget.idCliente, 6);

    ShowDialog(
      context: context,
      title: 'Hay una nueva versión',
      titleColor: Colors.blueAccent,
      updateButtonText: 'Actualizar',
      laterButtonText: 'Despues',
      body: '¿Queres Actualizarla ahora?',
      jsonUrl: URL + 'version.json',
    ).checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ListaOfertas(futuro: _ofertas),
              AccesosDirectos(),
              HomeDestacadosHogar(
                futuro: _destacadosHogar,
              ),
              SizedBox(
                height: 50,
              ),
              HomeDestacados(
                futuro: _destacadosComercial,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
          Visibility(
            visible: widget.idCliente != 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: BotonWhatsApp(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BotonLogin(),
            ),
          ),
        ],
      ),
    );
  }
}
