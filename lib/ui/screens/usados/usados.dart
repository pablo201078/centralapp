import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/usados.dart';
import 'package:centralApp/ui/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/ui/screens/usados/widgets/usados_body.dart';
import 'package:centralApp/ui/screens/usados/widgets/usados_lista_categorias.dart';
import 'package:centralApp/ui/screens/usados/widgets/usados_lista_vacia.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Usados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UsadosModel>(
      model: UsadosModel(),
      child: _Scaffold(),
    );
  }
}

class _Scaffold extends StatefulWidget {
  @override
  __ScaffoldState createState() => __ScaffoldState();
}

class __ScaffoldState extends State<_Scaffold> {
  int _index = 0;
  Future<List<Articulo>> _futuro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var articuloRepository = ArticuloRepository();
    _futuro = articuloRepository.getUsados(0);
  }

  @override
  Widget build(BuildContext context) {
    UsadosModel usadosModel =
        ScopedModel.of<UsadosModel>(context, rebuildOnChange: false);

    setState(() {
      _index = usadosModel.tipo - 1;
    });

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Segunda Mano',
        actions: [],
      ),
      body: Column(
        children: [
          UsadosListaCategorias(),
          Expanded(
            child: _Body(futuro: _futuro),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  Future<List<Articulo>> futuro;

  _Body({this.futuro});

  @override
  Widget build(BuildContext context) {
    UsadosModel usadosModel =
        ScopedModel.of<UsadosModel>(context, rebuildOnChange: false);

    return FutureBuilder<List<Articulo>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SinConexion();
        }

        if (!snapshot.hasData)
          return LoadingList(
            itemsCount: 7,
          );

        if (snapshot.data.isEmpty)
          return UsadosListaVacia();
        else {
          usadosModel.destacados = snapshot.data;
          return UsadosBody();
        }
      },
    );
  }
}
