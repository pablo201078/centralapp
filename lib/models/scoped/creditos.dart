import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../credito.dart';

class CreditosModel extends Model {
  List<Credito> _creditos = List<Credito>();
  int _tipo = 1; /*1=actuales, 2 = vencidos*/

  CreditosModel._privateConstructor();
  static final CreditosModel _instance = CreditosModel._privateConstructor();

  factory CreditosModel() {
    return _instance;
  }

  static CreditosModel of(BuildContext context) =>
      ScopedModel.of<CreditosModel>(context);

  set creditos(lista) {
    _creditos = lista;
  }

  set tipo(value) {
    _tipo = value;
    notifyListeners();
  }

  int get tipo {
    return _tipo;
  }

  vaciar(){
    _creditos = List<Credito>();
    notifyListeners();
  }

  List<Credito> get creditosActuales {
    //return _creditos.where((element) => !element.actual).toList();
    if (_tipo == 1)
      return _creditos.where((element) => element.actual).toList();
    else
      return _creditos.where((element) => !element.actual).toList();
  }
}
