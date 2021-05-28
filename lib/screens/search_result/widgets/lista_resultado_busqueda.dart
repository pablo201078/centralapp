import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/widgets/articulo_card/articulo_card.dart';
import 'package:flutter/material.dart';

class ListaResultadoBusqueda extends StatelessWidget {
  final List<Articulo> lista;
  ListaResultadoBusqueda({Key key, @required this.lista});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return ArticuloCard(articulo: lista[index]);
      },
    );
  }
}
