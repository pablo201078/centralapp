import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/scoped/usados.dart';
import 'package:centralApp/widgets/articulo_card/articulo_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../utils.dart';

class UsadosBody extends StatelessWidget {
  ScrollController controlador;

  @override
  Widget build(BuildContext context) {
    controlador = ScrollController(initialScrollOffset: 0);

    Future.delayed(Duration.zero, () {
      controlador.jumpTo(0);
    });

    UsadosModel usadosModel =
        ScopedModel.of<UsadosModel>(context, rebuildOnChange: true);

    List<Articulo> lista = usadosModel.destacados;

    return ListView.builder(
      controller: controlador,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: null,
          child: Container(
            height: SizeConfig.blockSizeVertical * 13,
            child: ArticuloCard(articulo: lista[index]),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.1,
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
