class ArticuloCategoria {
  final int idCategoria;
  final String nombre;
  final String nombreCorto;
  final int idTipo;
  final String url;

  ArticuloCategoria(
      {this.idCategoria, this.nombre, this.idTipo, this.url, this.nombreCorto});

  factory ArticuloCategoria.fromJson(Map<String, dynamic> jsonData) {
    return ArticuloCategoria(
      idCategoria: int.parse(jsonData['idCategoria']),
      nombre: jsonData['categoria'] as String,
      nombreCorto: jsonData['categoriaCorta'] as String,
      idTipo: int.parse(jsonData['idTipo']),
      url: jsonData['url'] as String,
    );
  }
}
