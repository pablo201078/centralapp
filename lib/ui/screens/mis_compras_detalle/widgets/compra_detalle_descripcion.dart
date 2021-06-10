import 'package:centralApp/data/models/credito.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/widgets/compra_detalle_cantidad_.dart';
import 'package:centralApp/ui/widgets/articulo_card/widgets/articulo_card_imagen_id.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';
import 'compra_detalla_plan.dart';

class CompraDetalleDescripcion extends StatelessWidget {
  const CompraDetalleDescripcion({
    Key key,
    @required this.credito,
  }) : super(key: key);

  final Credito credito;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(
                  credito.descripcion,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.3),
                  maxLines: 2,
                ),
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CompraDetalleCantidad(cantidad: credito.cantidad),
                    SizedBox(
                      width: 15,
                    ),
                    CompraDetallePlan(credito: credito),
                  ],
                ),
              ],
            ),
          ),
         ArticuloCardImagenId(idArticulo: credito.idArticulo, alto: 60,)
         /* credito.idArticulo == 0
              ? Image.asset(
                  'assets/imagenes/cash.png',
                  height: 60,
                )
              : Image(
                  height: 60,
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
                      'https://amacar.com.ar/images/cache/product-page/articulo-${credito.idArticulo}_0.png'),
                ),*/
        ],
      ),
    );
  }
}
