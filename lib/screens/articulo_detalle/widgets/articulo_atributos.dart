import 'package:centralApp/api/articulos.dart';
import 'package:centralApp/models/articulo.dart';
import 'package:centralApp/models/scoped/carrito.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:centralApp/notificaciones.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../utils.dart';

class ArticuloAtributos extends StatefulWidget {
  final Articulo articulo;

  ArticuloAtributos({Key key, this.articulo});

  @override
  _ArticuloAtributosState createState() => _ArticuloAtributosState();
}

class _ArticuloAtributosState extends State<ArticuloAtributos> {
  Atributo atributoActual;

  @override
  void initState() {
    super.initState();
    atributoActual = widget.articulo.atributo;
  }

  Widget _buildListaAtributos(
      BuildContext context, bool enCarrito, int idCliente) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: SizeConfig.blockSizeVertical * 20.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                endIndent: 20,
                indent: 20,
              ),
              itemCount: widget.articulo.atributos.length,
              itemBuilder: (context, index) {
                Color color = Colors.black;
                if (widget.articulo.atributos[index].idAtributo != 0)
                  color = atributoActual.idAtributo ==
                          widget.articulo.atributos[index].idAtributo
                      ? Theme.of(context).accentColor
                      : Colors.black;

                double size = SizeConfig.safeBlockHorizontal * 3.5;
                if (widget.articulo.atributos[index].idAtributo == 0) {
                  size = SizeConfig.safeBlockHorizontal * 4.5;
                }

                FontWeight weight = FontWeight.bold;
                if (widget.articulo.atributos[index].idAtributo != 0)
                  weight = atributoActual.idAtributo ==
                          widget.articulo.atributos[index].idAtributo
                      ? FontWeight.bold
                      : FontWeight.w300;

                TextStyle textStyle =
                    TextStyle(color: color, fontSize: size, fontWeight: weight);

                return GestureDetector(
                  onTap: () async {
                    if (widget.articulo.atributos[index].idAtributo != 0) {
                      widget.articulo.atributo =
                          widget.articulo.atributos[index];
                      setState(() {
                        atributoActual = widget.articulo.atributos[index];
                      });
                      Navigator.pop(context);
                      if (enCarrito &&
                          widget.articulo.atributos[index].idAtributo != 0) {
                        if (await actualizarCarrito(
                            this.widget.articulo, idCliente, true, context))
                          showSnackBar(
                              context, 'Actualizaste el Carrito', null);
                      }
                    }
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    padding: const EdgeInsets.all(6.0),
                    color: Colors.grey.withOpacity(0.0),
                    child: Text(
                      widget.articulo.atributos[index].atributo,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.clear,
                size: 30, color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final CarritoModel carritoModel =
        ScopedModel.of<CarritoModel>(context, rebuildOnChange: false);

    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return _buildListaAtributos(
                    context,
                    carritoModel.existe(widget.articulo),
                    loggedModel.getUser.idCliente);
              });
        },
        child: Container(
          height: SizeConfig.safeBlockVertical * 5.0,
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.withOpacity(0.2),
            border: Border.all(color: Colors.grey.withOpacity(0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Tipo:  ', style: TextStyle()),
                  Text('${atributoActual.atributo}',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.blueAccent)
            ],
          ),
        ),
      ),
    );
  }
}
