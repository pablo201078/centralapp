import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:centralApp/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';
import 'data/models/usuario.dart';

void mostrarOverlayBienvenida(BuildContext context, Usuario user) async {
  showOverlayNotification(
    (context) {
      return SafeArea(
        child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ]),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(' Bienvenido/a:  ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.2))
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).accentColor,
                  size: SizeConfig.blockSizeHorizontal * 10.0,
                ),
                title: Text(
                  user.nombre,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.0),
                ),
                trailing: Text(
                  user.localidad,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      );
    },
    duration: Duration(seconds: 3),
    position: NotificationPosition.bottom,
  );
}

void showSnackBar(BuildContext context, String texto, Color color) {
  Get.snackbar(
    'Central App',
    texto,
    colorText: Colors.white,
    backgroundColor: color ?? Theme.of(context).accentColor,
    duration: Duration(seconds: 3),
  );
}

showWarning(BuildContext context, onPress, String texto) {
  AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      title: 'Central App',
      desc: texto,
      btnOkOnPress: onPress)
    ..show();
}

showMessage(BuildContext context, String texto, DialogType type) {
  AwesomeDialog(
      context: context,
      dialogType: type ?? DialogType.INFO,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      title: 'Central App',
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      btnOkText: 'Ok',
      btnOkColor: Theme.of(context).accentColor,
      desc: texto)
    ..show();
}

showFinCompra(BuildContext context, Function click) {
  Widget bt = MaterialButton(
    onPressed: click,
    height: SizeConfig.safeBlockVertical * 5.5,
    elevation: 0.0,
    child: Container(
      // width: SizeConfig.safeBlockHorizontal * 33,
      child: Center(
        child: Text(
          'Aceptar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.safeBlockHorizontal * 3.0,
          ),
        ),
      ),
    ),
    color: Colors.blueAccent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
  );

  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    headerAnimationLoop: false,
    animType: AnimType.SCALE,
    title: 'Central App',
    dismissOnTouchOutside: false,
    // onDissmissCallback: click,
    btnOk: bt,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Finalizaste con Exito tu Compra!',
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Record?? que podes CANCELAR el pedido desde la secci??n:\n"Pedidos Actuales"',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: SizeConfig.safeBlockHorizontal * 3.0,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  )..show();
}

dialogoOrigenImagen(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '??Quer??s Cambiar la imagen de Perfil?',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            MaterialButton(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                Navigator.pop(context, 2);
              },
              color: Colors.blueAccent,
              child: Text(
                'Buscar una foto en mi Galer??a',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                Navigator.pop(context, 1);
              },
              color: Colors.blueAccent,
              child: Text(
                'Tomar una foto con la C??mara',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            MaterialButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                Navigator.pop(context, 0);
              },
              color: Colors.white,
              child: Text(
                'Cerrar',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        );
      });
}

dialogoCerrarApp(BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        '??Queres cerrar?',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'No',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
        MaterialButton(
          color: Theme.of(context).accentColor,
          onPressed: () {
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            }
            Navigator.of(context).pop(true);
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: Text(
            'Si, salir.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

dialogoOpcionesInicioSesion(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ya ten??s tu Cuenta activada en otro celular.\n??Que Quer??s hacer?',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: SizeConfig.safeBlockHorizontal * 4.0),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                elevation: 5.0,
                height: SizeConfig.safeBlockVertical * 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                color: Colors.blueAccent,
                child: Text(
                  'Generar 2?? Credencial de Pago',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                elevation: 10.0,
                height: SizeConfig.safeBlockVertical * 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                //  color: Colors.blueAccent,
                child: Text(
                  'Abrir Mi Cuenta en este celular',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                elevation: 5.0,
                height: SizeConfig.safeBlockVertical * 5.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                color: Colors.white,
                child: Text(
                  'Cerrar',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ],
        );
      });
}

dialogoInicioSesionTipoUsuario(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          '??Que Tipo de Cuenta vas a usar en este celular?',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeBlockHorizontal * 4.0),
        ),
        actions: [
          MaterialButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).accentColor),
            ),
            onPressed: () {
              Navigator.pop(context, 1);
            },
            child: RichText(
              text: TextSpan(
                text: 'Cuenta del ',
                style: TextStyle(color: Theme.of(context).accentColor),
                children: [
                  TextSpan(
                    text: 'TITULAR',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  )
                ],
              ),
            ),
          ),
          MaterialButton(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).accentColor),
            ),
            onPressed: () {
              Navigator.pop(context, 2);
            },
            child: RichText(
              text: TextSpan(
                text: 'SOLO',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: ' Tarjeta Cobranza',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

dialogoDebeIniciarSesion(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Antes tenes que iniciar sesi??n.',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          MaterialButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/loggin');
            },
            color: Colors.blueAccent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  MaterialCommunityIcons.qrcode,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Iniciar Sesi??n',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Future<DateTime> seleccionFecha(
    BuildContext context, DateTime min, DateTime max, dynamic click) {
  DatePicker.showDatePicker(
    context,
    minTime: min,
    maxTime: max,
    locale: LocaleType.es,
    showTitleActions: true,
    theme: DatePickerTheme(
      titleHeight: 48.0,
      itemHeight: 45.0,
      doneStyle: TextStyle(color: Colors.blue, fontSize: 18),
    ),
    onConfirm: click,
  );
}

Future<DateTime> seleccionFecha2(
    BuildContext context, DateTime min, DateTime max) {
  return showDatePicker(
    context: context,
    initialDate: min,
    firstDate: min,
    lastDate: max,
    helpText: 'Eleg?? la fecha de Renovaci??n',
    cancelText: 'Cancelar',
    confirmText: 'Ok',
    fieldLabelText: 'Fecha Renovaci??n',
  );
}
