import 'package:centralApp/api/categorias.dart';
import 'package:centralApp/models/articulo_categoria.dart';
import 'package:centralApp/models/scoped/categoria_comercial_actual.dart';
import 'package:centralApp/screens/equipamiento_comercial/widgets/comercial_categoria_actual.dart';
import 'package:centralApp/screens/equipamiento_comercial/widgets/lista_categorias.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/boton_buscar.dart';
import 'package:centralApp/widgets/boton_carrito.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuro = getCategorias(widget.idCliente, 2);
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
