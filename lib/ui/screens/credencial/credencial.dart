import 'dart:async';
import 'package:centralApp/data/repositories/usuario.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:centralApp/ui/screens/credencial/widgets/qr_actualizado.dart';
import 'package:centralApp/ui/screens/credencial/widgets/boton_compartir_qr.dart';
import 'package:centralApp/ui/screens/credencial/widgets/boton_actualizar_qr.dart';
import 'package:centralApp/ui/screens/credencial/widgets/tarjeta_dorso.dart';
import 'package:centralApp/ui/screens/credencial/widgets/tarjeta_frente.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:centralApp/utils.dart';
import 'package:get/get.dart';

class Credencial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final UsuarioBloc modelo =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);

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
  final UsuarioBloc usuario;

  _Body({@required this.usuario});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> with WidgetsBindingObserver {
  bool _mostrarBotonActualizarQr = false;
  bool _qrOk = false;
  bool _actualizando = false;
  var usuarioRepo = UsuarioRepository();
  ScreenshotController _screenshotController = ScreenshotController();

  void verificarQr() async {
    if (_actualizando) return;

    setState(() {
      _actualizando = true;
    });
    int rta = await usuarioRepo.checkQr(widget.usuario);
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
    WidgetsBinding.instance.addObserver(this);
    verificarQr();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      verificarQr();
    }
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
            _Tarjeta(),
            SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _Qr(
                  data: widget.usuario.getUser.qrCode,
                  size: SizeConfig.safeBlockVertical * 25,
                  screenshotController: _screenshotController,
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
            ),
          ),
        ),
        Visibility(
          visible: !_mostrarBotonActualizarQr,
          child: Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: BotonCompartirQr(
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
