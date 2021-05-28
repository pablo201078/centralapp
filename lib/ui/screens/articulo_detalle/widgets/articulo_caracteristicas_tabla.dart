import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class ArticuloCaracteristicasTabla extends StatelessWidget {
  final Articulo articulo;

  ArticuloCaracteristicasTabla({Key key, @required this.articulo});

  @override
  Widget build(BuildContext context) {
    return _buildTabla(context, articulo.caracteristicas);
  }
}

Widget _buildTabla(BuildContext context, List<Map<String, String>> lista) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Especificaciones Técnicas',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2.5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildFilasInfo(lista),
        ),
      ],
    ),
  );
}

List<Container> _buildFilasInfo(List<Map<String, String>> lista) {
  List<Container> filas = <Container>[];

  lista.forEach(
    (element) {
      bool inicio = element == lista[0];
      bool fin = element == lista[lista.length - 1];
      int index = lista.indexOf(element);
      filas.add(
        Container(
          height: 35,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 0.25),
            color: Colors.grey.withOpacity(index.isEven ? 0.1 : 0.32),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(inicio
                    ? 20
                    : 0), //si es la primera fila la hago redondeada arriba
                topRight: Radius.circular(inicio ? 20 : 0),
                bottomLeft: Radius.circular(fin ? 20 : 0),
                bottomRight: Radius.circular(
                    fin ? 20 : 0)), //si es la ultima la hago redondeada abajo
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    element.keys.single.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      element.values.single.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 11.5),
                    )),
              ],
            ),
          ),
        ),
      );
    },
  );

  return filas;
}
