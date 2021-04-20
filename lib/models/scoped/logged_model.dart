import 'dart:convert';
import 'package:centralApp/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';

import '../articulo.dart';

class LoggedModel extends Model {

  LoggedModel() {
    _init();
  }

  bool _isLogged = false;
  String _user;
  String _clave = '';
  int _deudaVencida = 0;
  List<String> _busquedas;
  List<Articulo> _favoritos = [];

  set clave(value) {
    _clave = value;
    notifyListeners();
  }

  String get clave => _clave;
  bool get isLogged => _isLogged;

  Usuario get getUser{
      print('get user: ' + _user);
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

  void actualizarDatos(qr, fecha, cierraSesion) {
    Usuario usr = this.getUser;
    usr.qr = qr;
    usr.setQrFecha = fecha;
    usr.cierraSesion = cierraSesion;
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

  static LoggedModel of(BuildContext context) =>
      ScopedModel.of<LoggedModel>(context);

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogged = prefs.getBool('isLogged') ?? false;
    _user = prefs.getString('user');
    notifyListeners();
  }

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
