import 'dart:typed_data';

import 'package:centralApp/api/usuario.dart';
import 'package:centralApp/models/scoped/carrito.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:centralApp/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'dart:io';
import '../notificaciones.dart';
import '../one_signal.dart';

Future<bool> validarUsuario(
    String dni, String clave, BuildContext context) async {
  Usuario usr = await getUsuarioClave(dni, clave, true, 1);

  //-1 = usuario o contraseñas incorrectas
  if (usr.idCliente == -1) {
    showWarning(context, () {}, usr.nombre);
    return false;
  }
  //0 = habia iniciado sesion desde otro dispositivo
  if (usr.idCliente == 0) {
    cuentaAbierta(dni, clave, context);
    return false;
  }
  //login ok
  var rta = await dialogoInicioSesionTipoUsuario(context);
  loginOk(usr, rta, context);
  return true;
}

Future validarUsuarioScan(String codigo, BuildContext context) async {
  Usuario usr = await getUsuario(codigo, true, 1);
  //-1 = usuario o contraseñas incorrectas
  if (usr.idCliente == -1) {
    showWarning(context, () {}, usr.nombre);
    return;
  }
  //0 = habia iniciado sesion desde otro dispositivo
  if (usr.idCliente == 0) {
    cuentaAbiertaScan(codigo, context);
    return;
  }
  //login ok
  var rta = await dialogoInicioSesionTipoUsuario(context);
  loginOk(usr, rta, context);
}

void cuentaAbierta(String dni, String clave, BuildContext context) async {
  var rta = await dialogoOpcionesInicioSesion(context);

  if (rta == 0) return;
  //rta:  1 =  cuenta normal, 2 = solo tarjeta
  Usuario usr = await getUsuarioClave(dni, clave, false, rta);
  loginOk(usr, rta, context);
}

void cuentaAbiertaScan(String codigo, BuildContext context) async {
  var rta = await dialogoOpcionesInicioSesion(context);

  if (rta == 0) return;
  //rta:  1 =  cuenta normal, 2 = solo tarjeta
  Usuario usr = await getUsuario(codigo, false, rta);
  loginOk(usr, rta, context);
}

void loginOk(Usuario usr, int tipoUsuario, BuildContext context) {
  final LoggedModel modelo =
      ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

  usr.idTipo = tipoUsuario;
  mostrarOverlayBienvenida(context, usr);
  modelo.logged = true;
  modelo.setUsuario(usr.toJson());
  print(usr.toJson());
  if (usr.idTipo == 1) {
    //aca registro el id del cliente en onesignal para notificaciones personalizadas
    abrirSesionOneSignal(usr.idCliente, usr.hash);
  }
  Navigator.of(context).pop();
}

void cerrarSesion(LoggedModel model, CarritoModel carritoModel) {
  model.logged = false;
  carritoModel.vaciar();
  cerrarSesionOneSignal();
}

//para cuando solicitan la clave por SMS
void enviarSms(BuildContext context) {
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  _sendSMS(
    "Solicito mi Clave",
    ["2364249956"],
  );
}

Future<void> compartirQr(ScreenshotController screenshotController,
    BuildContext context, int idCliente) async {

  bool rta = await postCompartirQr(idCliente);

  if ( !rta ){
    showSnackBar( context, 'No se pudo compartir el QR.', Colors.redAccent);
    return;
  }

  screenshotController.capture().then((Uint8List image) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/screenshot.png');
    await imgFile.writeAsBytes(image, flush: true);
    List<String> lista = List<String>();
    lista.add(imgFile.path);
    Share.shareFiles(lista, text: 'QR válido  solo para hoy.');
  });
}

/*
//para cuando solicitan la clave por SMS
void enviarSms(BuildContext context) {
  final Telephony telephony = Telephony.instance;

  final SmsSendStatusListener listener = (SendStatus status) {
    if (status == SendStatus.SENT)
      Get.snackbar(
        'Central App',
        'Enviando el SMS, por favor espere la respuesta.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black54,
      );
  };

 final LoggedModel modelo =
      ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

   telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        if (message.address == '+542364249956' ||
            message.address == '+542364249957' ||
            message.address == '+542364249958') {
          mostrarClaveRecibida(message.body);
          var clave = message.body
              .substring(message.body.indexOf(':', 1) + 1, message.body.length);
          print('la clave es :' + clave.trim());
          modelo.clave = clave.trim();
        }
      },
      listenInBackground: false);

  telephony.sendSms(
    to: "2364249956",
    message: "Solicito mi Clave",
    statusListener: listener,
  );
}*/

/*

void mostrarClaveRecibida(String sms) {
  Get.defaultDialog(
    radius: 10,
    titleStyle: TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
    title: 'Central App',
    middleTextStyle: TextStyle(
      color: Colors.blueAccent,
      letterSpacing: 1,
      fontSize: SizeConfig.safeBlockHorizontal * 4.2,
    ),
    middleText: sms,
    textConfirm: 'Cerrar',
    confirmTextColor: Colors.white,
    onConfirm: Get.routing.route.navigator.pop,
    onCancel: null,
  );
}
*/
