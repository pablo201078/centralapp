import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:centralApp/utils.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/boton_buscar.dart';
import 'package:centralApp/ui/widgets/boton_carrito.dart';
import 'package:centralApp/ui/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/ui/screens/search_result/widgets/lista_resultado_busqueda.dart';

class SearchResult extends StatelessWidget {
  String query;

  SearchResult({Key key, @required this.query});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.query = arguments['query'];

    return Scaffold(
      appBar: buildAppBar(context,
          title: 'Resultados:  ${query}',
          actions: [BotonBuscar(), BotonCarrito()]),
      body: _Body(
        query: query,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final String query;

  _Body({Key key, @required this.query});

  @override
  Widget build(BuildContext context) {
    final UsuarioBloc model =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: true);
    var articuloRepository = ArticuloRepository();
    return FutureBuilder<List<Articulo>>(
      future: articuloRepository.getSearch(model.isLogged ? model.getUser.idCliente : 0, query),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? _buildResultado(context, snapshot.data)
            : LoadingList(itemsCount: 10);
      },
    );
  }


  Widget _buildResultado(BuildContext context, List<Articulo> lista) {
    if (lista.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "No se encontraron resultados",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: SizeConfig.safeBlockHorizontal * 5.0),
            ),
          ),
        ],
      );
    }
    return ListaResultadoBusqueda(lista: lista);
  }
}
