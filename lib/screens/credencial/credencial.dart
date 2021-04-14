import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:centralApp/api/usuario.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:centralApp/screens/credencial/widgets/qr_actualizado.dart';
import 'package:centralApp/screens/credencial/widgets/boton_compartir_qr.dart';
import 'package:centralApp/screens/credencial/widgets/boton_actualizar_qr.dart';
import 'package:centralApp/screens/credencial/widgets/tarjeta_dorso.dart';
import 'package:centralApp/screens/credencial/widgets/tarjeta_frente.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';
import '../../utils.dart';
import 'package:get/get.dart';

class Credencial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final LoggedModel modelo =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Tarjeta de Socio',
        actions: [],
      ),
      body: _Body(usuario: modelo),
    );
  }
}

class _Body extends StatefulWidget {
  final LoggedModel usuario;

  _Body({@required this.usuario});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool _mostrarBotonActualizarQr = false;
  bool _qrOk = false;
  bool _actualizando = false;

  ScreenshotController _screenshotController = ScreenshotController();

  Timer timer;

  void verificarQr() async {
    if (_actualizando) return;

    setState(() {
      _actualizando = true;
    });
    int rta = await checkQr(widget.usuario);
    setState(() {
      _actualizando = false;
    });
    if (rta >= 1) {
      print('El Qr esta ok');
      setState(() {
        _mostrarBotonActualizarQr = false;
        _qrOk = true;
      });
      return;
    }
    if (rta == 0) {
      setState(() {
        _mostrarBotonActualizarQr = true;
        _qrOk = false;
      });
      Get.snackbar('Oops', 'No pudimos comprobar si tu Qr es válido');
      print('Error de conexion');
      return;
    }

    print('verificar qr: ' + rta.toString());
  }

  void clickActualizarQr() async {
    setState(() {
      _mostrarBotonActualizarQr = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificarQr();
    /*  timer = Timer.periodic(
      new Duration(seconds: 4),
      (time) async {
         bool rta = await getUltimoTicket(widget.usuario.getUser.idCliente);
        //bool int =
        //    await checkQr(widget.usuario.idCliente, widget.usuario.qrCode);
        print('check ticket');
        if (rta) {
          time.cancel();
          setState(() {
            _mostrarBotonTicket = true;
          });
        }
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            ElasticInRight(
              child: _Tarjeta(),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Pulse(
                  child: _Qr(
                    data: widget.usuario.getUser.qrCode,
                    size: SizeConfig.safeBlockVertical * 25,
                    screenshotController: _screenshotController,
                  ),
                ),
                Visibility(
                  visible: _qrOk,
                  child: QrActualizado(),
                )
              ],
            ),
          ],
        ),
        Visibility(
          visible: _mostrarBotonActualizarQr,
          child: Positioned(
              bottom: 12,
              left: SizeConfig.safeBlockHorizontal * 5.5,
              child: BotonActualizarQr(
                usuario: widget.usuario,
                actualizando: _actualizando,
                click: verificarQr, //clickActualizarQr,
              )),
        ),
        Visibility(
          visible: !_mostrarBotonActualizarQr,
          child: Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: BotonCompartirQr(
                usuario: widget.usuario.getUser,
                screenshotController: _screenshotController,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Tarjeta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: SizeConfig.safeBlockVertical * 30,
        width: SizeConfig.safeBlockHorizontal * 95,
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 500,
          front: TarjetaFrente(),
          back: TarjetaDorso(),
        ),
      ),
    );
  }
}

class _Qr extends StatelessWidget {
  final String data;
  final double size;
  final screenshotController;
  _Qr({this.data, this.size, this.screenshotController});

  @override
  Widget build(BuildContext context) {
      return Screenshot(
      controller: screenshotController,
      child: QrImage(
        data: data,
        embeddedImage: Image.asset(
          'assets/imagenes/amacar01.png',
        ).image,
        padding: EdgeInsets.all(4.5),
        backgroundColor: Colors.white,
        version: QrVersions.auto,
        size: size,
      ),
    );
  }
}
