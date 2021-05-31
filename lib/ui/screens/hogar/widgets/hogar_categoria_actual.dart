import 'dart:async';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo_categoria.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/categoria_actual.dart';
import 'package:centralApp/logic/logged_model.dart';
import 'package:centralApp/ui/widgets/articulo_card/articulo_card.dart';
import 'package:centralApp/ui/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HogarCategoriaActual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoriaActualModel model =
        ScopedModel.of<CategoriaActualModel>(context, rebuildOnChange: true);

    LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return _ListadoArticulos(
        categoria: model.categoriaActual,
        idCliente: loggedModel.isLogged ? loggedModel.getUser.idCliente : 0);
  }
}

class _ListadoArticulos extends StatelessWidget {
  final ArticuloCategoria categoria;
  final int idCliente;
  var articuloRepository = ArticuloRepository();
  _ListadoArticulos({this.categoria, this.idCliente});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articulo>>(
        future: articuloRepository.getArticulosPorCategoria(idCliente, 7, categoria.idCategoria),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? _Lista(lista: snapshot.data)
              : LoadingList(itemsCount: 8);
        });
  }
}

class _Lista extends StatelessWidget {
  final List<Articulo> lista;
  ScrollController controlador;
  _Lista({this.lista});

  Widget build(BuildContext context) {
    controlador = ScrollController(initialScrollOffset: 0);

    Future.delayed(Duration.zero, () {
      controlador.jumpTo(0);
    });

    return ListView.builder(
      itemCount: lista.length,
      controller: controlador,
      itemBuilder: (context, index) {
        return ArticuloCard(articulo: lista[index]);
      },
    );
  }
}
