import 'package:centralApp/data/models/credito.dart';
import 'package:centralApp/widgets/articulo_card/widgets/articulo_card_imagen_id.dart';
import 'package:centralApp/ui/screens/mis_compras/widgets/compra_card_detalle.dart';
import 'package:flutter/material.dart';

class CompraCard extends StatelessWidget {
  final Credito credito;

  CompraCard({Key key, @required this.credito});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 6),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: ArticuloCardImagenId(idArticulo: credito.idArticulo)),
          Expanded(flex: 2, child: CompraCardDetalle(credito: credito)),
        ],
      ),
    );
  }
}
