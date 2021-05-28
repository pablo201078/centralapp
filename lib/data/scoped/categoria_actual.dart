import 'package:centralApp/data/models/articulo_categoria.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoriaActualModel extends Model {
  CategoriaActualModel._privateConstructor();
  static final CategoriaActualModel _instance =
      CategoriaActualModel._privateConstructor();

  factory CategoriaActualModel() {
    return _instance;
  }

  int _index = 0;

  ArticuloCategoria _categoria =
      ArticuloCategoria(idCategoria: 1, nombre: 'Aberturas');

  ArticuloCategoria get categoriaActual => _categoria;

  String get categoriaActualNombre => _categoria.nombre;
  int get index => _index;

  set categoriaActual(value) {
    _categoria = value;
    //_controlador.animateTo(0.0, duration: null, curve: null);
    notifyListeners();
  }

  set index(value) {
    _index = value;
    notifyListeners();
  }
}
