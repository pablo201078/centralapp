import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UsadosModel extends Model {
  List<Articulo> _destacados = <Articulo>[];
  int _tipo = 1; /*1=destacados, 2 = hogar, 3 = equipamiento comercial*/

  UsadosModel._privateConstructor();
  static final UsadosModel _instance = UsadosModel._privateConstructor();

  factory UsadosModel() {
    return _instance;
  }

  static UsadosModel of(BuildContext context) =>
      ScopedModel.of<UsadosModel>(context);

  set destacados(lista) {
    _destacados = lista;
  }

  set tipo(value) {
    _tipo = value;
    notifyListeners();
  }

  int get tipo {
    return _tipo;
  }

  vaciar() {
    _destacados = List<Articulo>();
    notifyListeners();
  }

  List<Articulo> get destacados {
    if (_tipo == 1)
      return _destacados.where((element) => element.destacado).toList();
    if (tipo == 2)
      return _destacados
          .where(
              (element) => !element.destacado && !element.equipamientoComercial)
          .toList();
    if (tipo == 3)
      return _destacados
          .where(
              (element) => !element.destacado && element.equipamientoComercial)
          .toList();
  }
}
