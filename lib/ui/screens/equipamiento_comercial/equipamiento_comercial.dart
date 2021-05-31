import 'package:centralApp/data/repositories/categorias.dart';
import 'package:centralApp/data/models/articulo_categoria.dart';
import 'package:centralApp/logic/categoria_comercial_actual.dart';
import 'package:centralApp/ui/screens/equipamiento_comercial/widgets/comercial_categoria_actual.dart';
import 'package:centralApp/ui/screens/equipamiento_comercial/widgets/lista_categorias.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/boton_buscar.dart';
import 'package:centralApp/ui/widgets/boton_carrito.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EquipamientoComercial extends StatefulWidget {
  int idCliente;

  EquipamientoComercial({@required this.idCliente});

  @override
  _EquipamientoComercial createState() => _EquipamientoComercial();
}

class _EquipamientoComercial extends State<EquipamientoComercial> {
  Future<List<ArticuloCategoria>> futuro;
  var categoriaRepository = CategoriaRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuro = categoriaRepository.getCategorias(widget.idCliente, 2);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CategoriaComercialActualModel>(
      model: CategoriaComercialActualModel(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: 'Equipamiento Comercial',
          actions: [
            BotonBuscar(),
            BotonCarrito(),
          ],
        ),
        body: Column(
          children: [
            ListaCategorias(futuro: futuro),
            Expanded(
              child: ComercialCategoriaActual(),
            ),
          ],
        ),
      ),
    );
  }
}
