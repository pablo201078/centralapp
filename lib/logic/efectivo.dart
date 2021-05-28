import 'package:centralApp/data/repositories/usuario.dart';
import 'package:centralApp/data/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/notificaciones.dart';
import 'package:get/get.dart';
import 'package:centralApp/utils.dart';

void comprobarVencimiento(BuildContext context, int idCliente) async {
  var usuarioRepo = UsuarioRepository();
  Vencimiento vencimiento = await usuarioRepo.checkVencimiento(idCliente);
  /*
  * ok = 1 esta entre el 90 y el 100
  *
  * */
  if (vencimiento.ok == 1) {
    print('vencimiento: ${vencimiento.ok}');

    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushNamed('/renovacion_efectivo',
          arguments: {'vencimiento': vencimiento});
    });
  }
}

void comprobarVencimiento2(BuildContext context, int idCliente) async {
  var usuarioRepo = UsuarioRepository();
  Vencimiento vencimiento = await usuarioRepo.checkVencimiento(idCliente);

  if (vencimiento.ok > 0) {
    Navigator.of(context).pushNamed('/renovacion_efectivo',
        arguments: {'vencimiento': vencimiento});
  } else {
    if (vencimiento.ok == 0)
      contactarAsesor(context, idCliente);
    else {
      showWarning(context, () {}, 'Actualmente existe un crédito vigente.');
    }
  }
}

void confirmarRenovacion(
    BuildContext context, int idCliente, String monto, DateTime fecha) {
  Get.defaultDialog(
    radius: 10,
    titleStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
    title: 'Ayuda Económica',
    middleTextStyle: TextStyle(
      color: Theme.of(context).accentColor,
      letterSpacing: 1,
      fontSize: SizeConfig.safeBlockHorizontal * 4.2,
    ),
    middleText:
        ' ¿Solicita ${monto} para el día: ${formatearFechaStr(fecha)}? ',
    textConfirm: 'Confirmar',
    confirmTextColor: Colors.white,
    textCancel: 'Cancelar',
    onConfirm: () async {
      var usuarioRepo = UsuarioRepository();
      bool rta = await usuarioRepo.postRenovacionEfectivo(idCliente, fecha);
      if (rta) {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/pedidos',
            arguments: {'idCliente': idCliente});
      } else
        showSnackBar(context, 'Oops, algo salió mal', Colors.redAccent);
    },
    onCancel: null,
  );
}

Future renovarEfectivo(
    BuildContext context, int idCliente, String monto) async {
  dynamic click = (DateTime fecha) async {
    if (fecha != null) confirmarRenovacion(context, idCliente, monto, fecha);
  };

  DateTime fecha = DateTime.now();
  await seleccionFecha(
    context,
    fecha.add(Duration(days: 1)),
    fecha.add(Duration(days: 9)),
    click,
  );

/*  DateTime fecha = DateTime.now();
  fecha = await seleccionFecha2(
    context,
    fecha.add(Duration(days: 1)),
    fecha.add(Duration(days: 7)),
  );
  if (fecha != null) {
    print('Fecha renovacion: ' + fecha.toString());

    bool rta = await postRenovacionEfectivo(idCliente, fecha);
    if (rta) {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/pedidos',
          arguments: {'idCliente': idCliente});
    } else
      showSnackBar(context, 'Oops, algo salió mal', Colors.redAccent);
  }*/
}

Future contactarAsesor(BuildContext context, int idCliente) async {
  Get.defaultDialog(
    radius: 10,
    titleStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
    title: 'Ayuda Económica',
    middleTextStyle: TextStyle(
      color: Theme.of(context).accentColor,
      letterSpacing: 1,
      fontSize: SizeConfig.safeBlockHorizontal * 4.2,
    ),
    middleText: ' ¿Queres  que  te  llame  un  asesor? ',
    textConfirm: 'Si, quiero que me llamen',
    confirmTextColor: Colors.white,
    textCancel: 'Por ahora no',
    onConfirm: () async {
      var usuarioRepo = UsuarioRepository();
      bool rta = await usuarioRepo.postContactarAsesor(idCliente);
      if (rta) {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/pedidos',
            arguments: {'idCliente': idCliente});
      } else
        showSnackBar(context, 'Oops, algo salió mal', Colors.redAccent);
    },
    onCancel: null,
  );
}
