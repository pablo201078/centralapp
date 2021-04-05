import 'package:centralApp/api/pedidos.dart';
import 'package:centralApp/models/pedido.dart';
import 'package:centralApp/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../utils.dart';

class DetallePedidoTimeLine extends StatefulWidget {
  final Pedido pedido;

  DetallePedidoTimeLine({this.pedido});

  @override
  _DetallePedidoTimeLineState createState() => _DetallePedidoTimeLineState();
}

class _DetallePedidoTimeLineState extends State<DetallePedidoTimeLine> {
  Future<List<PedidoEtapa>> _future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getPedidoEtapas(widget.pedido.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PedidoEtapa>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return Container(
          width: double.infinity,
          height: SizeConfig.safeBlockVertical * 55,
          child: snapshot.hasData
              ? _TimelineDelivery(etapas: snapshot.data)
              : LoadingList(
                  itemsCount: 3,
                ),
        );
      },
    );
  }
}

class _TimelineDelivery extends StatelessWidget {
  final List<PedidoEtapa> etapas;
  _TimelineDelivery({this.etapas});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: etapas.length,
      itemBuilder: (context, index) {
        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: index == 0,
          isLast: index == etapas.length - 1,
          indicatorStyle: IndicatorStyle(
            width: etapas[index].actual ? 27 : 20,
            iconStyle: !etapas[index].futuro
                ? IconStyle(iconData: Icons.check, color: Colors.white)
                : null,
            color: etapas[index].futuro
                ? Colors.grey.withOpacity(0.6)
                : Theme.of(context).accentColor,
            padding: EdgeInsets.all(2),
          ),
          endChild: _Nodo(
            etapa: etapas[index],
          ),
          beforeLineStyle: LineStyle(
            color: etapas[index].futuro
                ? Colors.grey.withOpacity(0.6)
                : Theme.of(context).accentColor,
          ),
          afterLineStyle: LineStyle(
            color: (etapas[index].actual || etapas[index].futuro)
                ? Colors.grey.withOpacity(0.6)
                : Theme.of(context).accentColor,
          ),
        );
      },
    );
  }
}

class _Nodo extends StatelessWidget {
  final PedidoEtapa etapa;

  const _Nodo({
    Key key,
    this.etapa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(
              'assets/imagenes/pedidos/${etapa.id}.png',
              height: 40,
            ),
            opacity: etapa.futuro ? 0.2 : 1,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                etapa.descripcion + '  ',
                maxLines: 1,
                style: TextStyle(
                  fontWeight:
                      etapa.futuro ? FontWeight.normal : FontWeight.bold,
                  color: etapa.futuro ? Colors.grey: etapa.color,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                etapa.fecha,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
