import 'package:auto_size_text/auto_size_text.dart';
import 'package:centralApp/logic/scoped/categoria_comercial_actual.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/data/models/articulo_categoria.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';


import '../../../utils.dart';

class ListaCategorias extends StatelessWidget {
  Future<List<ArticuloCategoria>> futuro;

  ListaCategorias({@required this.futuro});

  @override
  Widget build(BuildContext context) {
    CategoriaComercialActualModel model =
        ScopedModel.of<CategoriaComercialActualModel>(context,
            rebuildOnChange: false);

    return FutureBuilder<List<ArticuloCategoria>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (!snapshot.hasData) return CircularProgressIndicator();
        return _Lista(lista: snapshot.data, posicion: model.index);
      },
    );
  }
}

class _Lista extends StatefulWidget {
  final List<ArticuloCategoria> lista;
  final int posicion;
  final double anchoBoton = 80;
  final double altoBoton = 90;

  _Lista({@required this.lista, @required this.posicion});

  @override
  __ListaState createState() => __ListaState();
}

class __ListaState extends State<_Lista> {
  ScrollController controlador;

  @override
  void initState() {
    controlador = ScrollController(
        initialScrollOffset: widget.posicion * widget.anchoBoton);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoriaComercialActualModel model =
        ScopedModel.of<CategoriaComercialActualModel>(context,
            rebuildOnChange: false);

    model.categoriaActual = widget.lista[model.index];

    return Column(
      children: [
        Container(
          height: widget.altoBoton,
          margin: EdgeInsets.only(top: 20, bottom: 12),
          child: ListView.builder(
            controller: controlador,
            scrollDirection: Axis.horizontal,
            itemCount: widget.lista.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    model.index = index;
                    model.categoriaActual = widget.lista[index];
                    HapticFeedback.heavyImpact();
                  });
                },
                child: _BotonCategoria(
                  lista: widget.lista,
                  index: index,
                  color: index == model.index
                      ? Theme.of(context).accentColor.withOpacity(0.6)
                      : Colors.white,
                  colorTexto: index == model.index
                      ? Colors.white
                      : Theme.of(context).accentColor.withOpacity(0.6),
                  ancho: widget.anchoBoton,
                ),
              );
            },
          ),
        ),
        _Encabezado(
          txt: model.categoriaActualNombre,
        ),
        Divider(
          thickness: 1.0,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}

class _Encabezado extends StatelessWidget {
  final String txt;
  _Encabezado({this.txt});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 5,
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}

class _BotonCategoria extends StatelessWidget {
  final List<ArticuloCategoria> lista;
  final int index;
  final Color color;
  final Color colorTexto;
  final double ancho;

  _BotonCategoria(
      {this.lista, this.index, this.color, this.colorTexto, this.ancho});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.ancho,
      margin: EdgeInsets.only(
        left: 10,
        right: index == lista.length - 1 ? 10 : 0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ImagenCategoria(url: lista[index].url, color: colorTexto),
          AutoSizeText(
            lista[index].nombreCorto,
            //    overflowReplacement: Text('....'),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: colorTexto, fontWeight: FontWeight.normal, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _ImagenCategoria extends StatelessWidget {
  final String url;
  final Color color;
  _ImagenCategoria({@required this.url, @required this.color});

  @override
  Widget build(BuildContext context) {
    print(url);
    return SvgPicture.network(
      url,
      color: color,
      width: 29,
      height: 29,
    );
  }
}
