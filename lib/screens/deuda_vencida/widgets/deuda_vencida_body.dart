import 'package:centralApp/models/credito.dart';
import 'package:centralApp/screens/mis_compras_detalle/widgets/compra_detalle_deuda.dart';
import 'package:centralApp/widgets/articulo_card/widgets/articulo_card_imagen_id.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class DeudaVencidaBody extends StatelessWidget {
  final List<Credito> lista;

  DeudaVencidaBody({this.lista});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return CompraDetalleDeuda(
                  idCredito: lista[index].idCredito,
                );
              },
            );
          },
          child: Container(
            height: SizeConfig.blockSizeVertical * 13,
            child: _Card(credito: lista[index]),
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

class _Card extends StatelessWidget {
  final Credito credito;

  _Card({Key key, @required this.credito});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 6),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: ArticuloCardImagenId(idArticulo: credito.idArticulo)),
          Expanded(flex: 2, child: _CardDetalle(credito: credito)),
        ],
      ),
    );
  }
}

class _CardDetalle extends StatelessWidget {
  final Credito credito;

  _CardDetalle({this.credito});

  String txt;

  @override
  Widget build(BuildContext context) {
    txt = 'Deuda:  ${formatearNumero(credito.deuda)}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(credito.descripcion,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w500),
            maxLines: 2),
        Visibility(
          visible: credito.idTipo == 2,
          child: Text(
            'Código: ${credito.codArticulo}',
            style: TextStyle(
              color: Colors.black, //Theme.of(context).accentColor,
              //  fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeBlockHorizontal * 3.0,
            ),
          ),
        ),
        SizedBox(
          height: 7.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              txt,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
