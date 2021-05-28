import 'package:centralApp/data/scoped/creditos.dart';
import 'package:centralApp/data/models/credito.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../utils.dart';
import 'compra_card.dart';

class MisComprasBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CreditosModel creditosModel =
        ScopedModel.of<CreditosModel>(context, rebuildOnChange: true);
    List<Credito> lista = creditosModel.creditosActuales;

    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: lista[index].actual ? () {
            Navigator.pushNamed(context, '/mis_compras_detalle',
                arguments: {'credito': lista[index]});
          }: null,
          child: Container(
            height: SizeConfig.blockSizeVertical * 13,
            child: CompraCard(credito: lista[index]),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).accentColor,
                    style: BorderStyle.solid),
              ),
            ),
          ),
        );
      },
      itemCount: lista.length,
    );
  }
}
