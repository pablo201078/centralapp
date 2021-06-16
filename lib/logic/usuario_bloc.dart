import 'dart:convert';
import 'dart:io';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/data/models/usuario.dart';
import 'package:centralApp/data/repositories/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
import 'package:centralApp/notificaciones.dart';
import 'package:centralApp/one_signal.dart';
import 'package:centralApp/utils.dart';
import 'carrito.dart';

class UsuarioBloc extends Model {
  UsuarioBloc() {
    _init();
  }

  bool _isLogged = false;
  String _user;
  String _clave = '';
  int _deudaVencida = 0;
  List<String> _busquedas;
  List<Articulo> _favoritos = [];

  static UsuarioBloc of(BuildContext context) =>
      ScopedModel.of<UsuarioBloc>(context);

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogged = prefs.getBool('isLogged') ?? false;
    _user = prefs.getString('user');
    notifyListeners();
  }

  set clave(value) {
    _clave = value;
    notifyListeners();
  }

  set logged(value) {
    _isLogged = value;
    saveEstado(value);
    if (!value) {
      _deudaVencida = 0;
      _favoritos.clear();
    }
    // Then notify all the listeners.
    notifyListeners();
  }

  void setUsuario(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(value));
    _user = json.encode(value);
    print('Guardando usuario: ' + _user);
    notifyListeners();
  }

  String get clave => _clave;
  bool get isLogged => _isLogged;

  Usuario get getUser {
    return Usuario.fromJson(
      json.decode(_user),
    );
  }

  void saveEstado(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', value);
  }

  void actualizarQr(value, fecha) {
    Usuario usr = this.getUser;
    usr.qr = value;
    usr.setQrFecha = fecha;
    //   usr.cierraSesion = true;
    print('actualizar QR: ' + usr.cierraSesion.toString());
    this.setUsuario(usr);
  }

  void actualizarDatos(qr, fecha, cierraSesion, nroSocio, rubro) {
    Usuario usr = this.getUser;
    if (qr != '') usr.qr = qr;
    if (fecha != '') usr.setQrFecha = fecha;
    if (cierraSesion != '') usr.cierraSesion = cierraSesion == '1';
    if (nroSocio != '') usr.nroSocio = nroSocio;
    if (rubro != '') usr.rubro = rubro;

    print('actualizar Datos: ' + usr.cierraSesion.toString());
    this.setUsuario(usr);
  }

  void actualizarHash(value) {
    Usuario usr = this.getUser;
    usr.hash = value;
    this.setUsuario(usr);
  }

  void actualizarUrlImagen(value) {
    Usuario usr = this.getUser;
    usr.imagen = value;
    this.setUsuario(usr);
  }

  Future<bool> validarUsuario(
      String dni, String clave, BuildContext context) async {
    var usuarioRepo = UsuarioRepository();

    Usuario usr = await usuarioRepo.getUsuarioClave(dni, clave, true, 1);

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
    _loginOk(usr, rta, context);
    return true;
  }

  Future validarUsuarioScan(String codigo, BuildContext context) async {
    var usuarioRepo = UsuarioRepository();
    Usuario usr = await usuarioRepo.getUsuario(codigo, true, 1);
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
    _loginOk(usr, rta, context);
  }

  void cuentaAbierta(String dni, String clave, BuildContext context) async {
    var rta = await dialogoOpcionesInicioSesion(context);
    var usuarioRepo = UsuarioRepository();
    if (rta == 0) return;
    //rta:  1 =  cuenta normal, 2 = solo tarjeta
    Usuario usr = await usuarioRepo.getUsuarioClave(dni, clave, false, rta);
    _loginOk(usr, rta, context);
  }

  void cuentaAbiertaScan(String codigo, BuildContext context) async {
    var rta = await dialogoOpcionesInicioSesion(context);

    if (rta == 0) return;
    //rta:  1 =  cuenta normal, 2 = solo tarjeta
    var usuarioRepo = UsuarioRepository();
    Usuario usr = await usuarioRepo.getUsuario(codigo, false, rta);
    _loginOk(usr, rta, context);
  }

  void _loginOk(Usuario usr, int tipoUsuario, BuildContext context) {
    usr.idTipo = tipoUsuario;
    mostrarOverlayBienvenida(context, usr);
    this.logged = true;
    this.setUsuario(usr.toJson());
    print(usr.toJson());
    if (usr.idTipo == 1) {
      //aca registro el id del cliente en onesignal para notificaciones personalizadas
      abrirSesionOneSignal(usr.idCliente, usr.hash);
    }
    Navigator.of(context).pop();
  }

  void cerrarSesion(CarritoModel carritoModel) {
    this.logged = false;
    carritoModel.vaciar();
    if (Platform.isAndroid || Platform.isIOS) cerrarSesionOneSignal();
  }

//para cuando solicitan la clave por SMS
  void enviarSms() {
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

  /*setQrForShare() {
    //modifico temporalmente el QR para campartirlo. La app de la cobradora lo puedo leer modificado pero la del supervisor no.
    //esto es para q los qr solo se puedan compartir con las cobradoras
    this.getUser.qrCode = this.getUser.qrCode + '*';
    notifyListeners();
  }*/

  Future<void> compartirQr(
      ScreenshotController screenshotController, BuildContext context) async {
    var usuarioRepo = UsuarioRepository();

    bool rta = await usuarioRepo.postCompartirQr(this.getUser.idCliente);

    if (!rta) {
      showSnackBar(context, 'No se pudo compartir el QR.', Colors.redAccent);
      return;
    }

    screenshotController.capture().then((Uint8List image) async {
      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = File('$directory/screenshot.png');
      await imgFile.writeAsBytes(image, flush: true);
      List<String> lista = <String>[];
      lista.add(imgFile.path);
      Share.shareFiles(lista, text: 'QR válido  solo para hoy.');
    });
  }

  void contactoWhatsApp() {
    String texto =
        'Hola soy ${this.getUser.nombre} de ${this.getUser.localidad}, necesito contactar un asesor.';

    _launchWhatsApp(phone: '542364326738', message: texto);
  }

  void _launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return 'https://api.whatsapp.com/send?phone=$phone&text=${Uri.parse(message)}';
        //return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  Future contactarAsesor(BuildContext context) async {
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
      middleText: ' ¿Querés  que  te  llame  un  asesor? ',
      textConfirm: 'Si, quiero que me llamen',
      confirmTextColor: Colors.white,
      textCancel: 'Por ahora no',
      onConfirm: () async {
        var usuarioRepo = UsuarioRepository();
        bool rta =
            await usuarioRepo.postContactarAsesor(this.getUser.idCliente);
        if (rta) {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/pedidos',
              arguments: {'idCliente': this.getUser.idCliente});
        } else
          showSnackBar(context, 'Oops, algo salió mal', Colors.redAccent);
      },
      onCancel: null,
    );
  }

  //favoritos
  List<Articulo> get favoritos => _favoritos;
  int get favoritosCantidad => _favoritos.length;
  set favoritos(lista) {
    _favoritos = lista;
    notifyListeners();
  }

  void eliminarFavorito(Articulo articulo) {
    _favoritos
        .removeWhere((element) => element.idArticulo == articulo.idArticulo);
    notifyListeners();
  }

  void agregarFavorito(Articulo articulo) {
    _favoritos.add(articulo);
    notifyListeners();
  }

  List<String> get busquedas => _busquedas;

  set busquedas(lista) {
    _busquedas = lista;
  }

  set deudaVencida(value) {
    _deudaVencida = value;
  }

  int get deudaVencida {
    return _deudaVencida;
  }
}
