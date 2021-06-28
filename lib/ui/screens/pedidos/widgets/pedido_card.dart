import 'package:animations/animations.dart';
import 'package:centralApp/data/models/pedido.dart';
import 'package:centralApp/ui/screens/pedido_detalle/pedido_detalle.dart';
import 'package:centralApp/ui/widgets/articulo_card/widgets/articulo_card_imagen_id.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class PedidoCard extends StatelessWidget {
  final Pedido pedido;
  PedidoCard({this.pedido});
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      closedBuilder: (BuildContext c, VoidCallback action) => _Container(
        pedido: pedido,
      ),
      openBuilder: (BuildContext c, VoidCallback action) =>
          PedidoDetalle(pedido: pedido),
      tappable: pedido.idTipo == 2,
    );

    /*return GestureDetector(
      onTap: pedido.idTipo == 2
          ? () {
              Navigator.pushNamed(context, '/pedido_detalle',
                  arguments: {'pedido': pedido});
            }
          : null,
      child: Container(
        height: SizeConfig.blockSizeVertical * 13,
        child: _ContenidoCard(pedido: pedido),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 0.5,
                color: Theme.of(context).accentColor,
                style: BorderStyle.solid),
          ),
        ),
      ),
    );*/
  }
}

class _Container extends StatelessWidget {
  final Pedido pedido;

  _Container({this.pedido});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 13,
      child: _ContenidoCard(pedido: pedido),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 0.5,
              color: Theme.of(context).accentColor,
              style: BorderStyle.solid),
        ),
      ),
    );
  }
}

class _ContenidoCard extends StatelessWidget {
  final Pedido pedido;

  _ContenidoCard({@required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ArticuloCardImagenId(idArticulo: pedido.idArticulo),
          ),
          Expanded(flex: 2, child: _CardDetalles(pedido: pedido)),
        ],
      ),
    );
  }
}

class _CardDetalles extends StatelessWidget {
  final Pedido pedido;

  _CardDetalles({@required this.pedido});

  @override
  Widget build(BuildContext context) {
    Color color;
    FontWeight fontWeight = FontWeight.w400;
    color = Colors.blueGrey;

    switch (pedido.idEstado) {
      case 10: //en lista
        {
          color = Colors.blueGrey;
        }
        break;
      case 20: //desautorizado
        {
          color = Colors.redAccent;
        }
        break;
      case 35: //sin stock
        {
          color = Colors.black54;
          fontWeight = FontWeight.bold;
        }
        break;
      case 40: //transito
        {
          color = Colors.green;
        }
        break;
      case 50: //descartado
        {
          color = Colors.red[300];
        }
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pedido.idTipo == 1
            ? _Descripcion(
                descripcion: pedido.descripcion,
              )
            : _Mensaje(
                mensaje: pedido.mensaje,
                color: color,
                fontWeight: fontWeight,
              ),
        SizedBox(
          height: 7.0,
        ),
        pedido.idTipo == 1
            ? _Mensaje(
                mensaje: pedido.mensaje,
                color: color,
                fontWeight: fontWeight,
              )
            : _Descripcion(
                descripcion: pedido.descripcion,
              ),
        Visibility(
          visible: pedido.idTipo == 1,
          child: SizedBox(
            height: 7.0,
          ),
        ),
        Visibility(
          visible: pedido.idTipo == 1,
          child: Text(
            pedido.fecha,
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

class _Descripcion extends StatelessWidget {
  final String descripcion;

  _Descripcion({this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Text(
      descripcion,
      style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
      maxLines: 2,
    );
  }
}

class _Mensaje extends StatelessWidget {
  final String mensaje;
  final Color color;
  final FontWeight fontWeight;

  _Mensaje({this.mensaje, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      mensaje,
      style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 4.0,
          color: color,
          fontWeight: fontWeight),
    );
  }
}
