import 'package:centralApp/data/repositories/categorias.dart';
import 'package:centralApp/data/models/articulo_categoria.dart';
import 'package:centralApp/logic/scoped/categoria_actual.dart';
import 'package:centralApp/screens/hogar/widgets/hogar_categoria_actual.dart';
import 'package:centralApp/screens/hogar/widgets/lista_categorias.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/boton_buscar.dart';
import 'package:centralApp/widgets/boton_carrito.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Hogar extends StatefulWidget {
  int idCliente;

  Hogar({@required this.idCliente});

  @override
  _HogarState createState() => _HogarState();
}

class _HogarState extends State<Hogar> {
  Future<List<ArticuloCategoria>> futuro;
  var categoriaRepository = CategoriaRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuro = categoriaRepository.getCategorias(widget.idCliente, 1);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CategoriaActualModel>(
      model: CategoriaActualModel(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: 'Hogar',
          actions: [
            BotonBuscar(),
            BotonCarrito(),
          ],
        ),
        body: Column(
          children: [
            ListaCategorias(futuro: futuro),
            Expanded(
              child: HogarCategoriaActual(),
            ),
          ],
        ),
      ),
    );
  }
}
