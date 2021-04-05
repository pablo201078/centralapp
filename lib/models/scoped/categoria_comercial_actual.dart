import 'package:centralApp/models/articulo_categoria.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoriaComercialActualModel extends Model {
  CategoriaComercialActualModel._privateConstructor();
  static final CategoriaComercialActualModel _instance =
      CategoriaComercialActualModel._privateConstructor();

  factory CategoriaComercialActualModel() {
    return _instance;
  }

  int _index = 0;
  ArticuloCategoria _categoria =
      ArticuloCategoria(idCategoria: 9, nombre: 'Balanzas');

  ArticuloCategoria get categoriaActual => _categoria;
  String get categoriaActualNombre => _categoria.nombre;

  int get index => _index;

  set categoriaActual(value) {
    _categoria = value;
    notifyListeners();
  }

  set index(value) {
    _index = value;
    notifyListeners();
  }
}
