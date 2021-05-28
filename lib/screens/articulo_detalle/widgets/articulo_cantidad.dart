import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/data/scoped/carrito.dart';
import 'package:centralApp/data/scoped/logged_model.dart';
import 'package:centralApp/notificaciones.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../utils.dart';

class ArticuloCantidad extends StatefulWidget {
  final Articulo articulo;

  ArticuloCantidad({Key key, this.articulo});

  @override
  _ArticuloCantidadState createState() => _ArticuloCantidadState();
}

class _ArticuloCantidadState extends State<ArticuloCantidad> {
  int cantidad = 1;

  var articuloRepository = ArticuloRepository();

  @override
  void initState() {
    super.initState();
    cantidad = widget.articulo.cantidad;
  }

  Widget _buildListaCantidades(
      BuildContext context, bool enCarrito, int idCliente) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: SizeConfig.blockSizeVertical * 50.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                endIndent: 20,
                indent: 20,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                String txt = '${index + 1}    Unidad';
                if (index > 0) txt += 'es';
                return GestureDetector(
                  onTap: () async {
                    widget.articulo.cantidad = index + 1;
                    setState(() {
                      cantidad = index + 1;
                    });
                    Navigator.pop(context);
                    if (enCarrito) {
                      if (await articuloRepository.actualizarCarrito(
                        this.widget.articulo,
                        idCliente,
                        true,
                        context,
                      )) showSnackBar(context, 'Actualizaste el Carrito', null);
                    }
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    padding: const EdgeInsets.all(6.0),
                    color: Colors.grey.withOpacity(0.0),
                    child: Text(
                      txt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          color: cantidad == index + 1
                              ? Theme.of(context).accentColor
                              : Colors.black,
                          fontWeight: cantidad == index + 1
                              ? FontWeight.bold
                              : FontWeight.w300),
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
                  size: 30, color: Theme.of(context).accentColor)),
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
              return _buildListaCantidades(
                  context,
                  carritoModel.existe(widget.articulo),
                  loggedModel.getUser.idCliente);
            },
          );
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
                  Text('Cantidad:  ', style: TextStyle()),
                  Text('${cantidad}',
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
