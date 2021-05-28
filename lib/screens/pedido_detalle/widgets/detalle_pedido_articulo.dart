import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/pedido.dart';
import 'package:centralApp/screens/pedido_detalle/widgets/pedido_cantidad_.dart';
import 'package:centralApp/utils.dart';
import 'package:flutter/material.dart';

class DetallePedidoArticulo extends StatelessWidget {
  final Pedido pedido;

  DetallePedidoArticulo({this.pedido});
  var articuloRepository = ArticuloRepository();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'idArticulo': pedido.idArticulo});
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    pedido.descripcion,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.1),
                    maxLines: 1,
                  ),
                  Text(
                    'Código: ${pedido.codArticulo}',
                    style: TextStyle(
                      color: Colors.black, //Theme.of(context).accentColor,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PedidoCantidad(cantidad: pedido.cantidad),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              child: Image(
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(
                  articuloRepository.url_img(pedido.idArticulo, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
