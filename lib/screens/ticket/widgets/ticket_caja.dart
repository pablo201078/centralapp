import 'package:auto_size_text/auto_size_text.dart';
import 'package:centralApp/logic/scoped/logged_model.dart';
import 'package:centralApp/data/models/ticket_item.dart';
import 'package:centralApp/utils.dart';
import 'package:centralApp/widgets/elevated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class TicketCaja extends StatelessWidget {
  List<TicketItem> items;

  TicketCaja({this.items});

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      shadowColor: Colors.black87,
      height: SizeConfig.safeBlockVertical * 70,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      child: Column(
        children: [
          items[0].hoy ?? false
              ? _Encabezado()
              : _WarningTicket(hoy: items[0].hoyDia),
          Expanded(
            child: _Detalle(items: items),
          ),
          _Total(items: items)
        ],
      ),
    );
  }
}

class _WarningTicket extends StatelessWidget {
  final String hoy;

  _WarningTicket({this.hoy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 25, top: 20),
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              //  color: Colors.blueAccent.withOpacity(0.6),
              borderRadius: BorderRadius.circular(5.0),
              border:
                  Border.all(width: 0.4, color: Theme.of(context).primaryColor),
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent.withOpacity(0.6),
                  Colors.redAccent.withOpacity(0.8),
                  Colors.red.withOpacity(0.9),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Este Ticket no es de Hoy.',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Hoy $hoy tu pago no fué efectuado.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.warning, color: Colors.white),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 60,
      width: 200,
      child: Column(
        children: [
          Text(
            'Detalle',
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                shadows: [
                  const BoxShadow(
                    color: Colors.black54,
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 3),
          ),
          Divider(
            thickness: 2,
            indent: 40,
            endIndent: 40,
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}

class _Detalle extends StatelessWidget {
  List<TicketItem> items;

  _Detalle({this.items});

  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Divider(
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).accentColor,
        );
      },
      itemBuilder: (context, index) {
        bool deuda = items[index].deuda > 0;
        bool adelanto = items[index].adelanto > 0;

        //deuda = false;
        //adelanto = true;
        String subtitulo = '';
        Color colorSub = Colors.black;
        if (deuda) {
          subtitulo = 'Deuda: ' + formatearNumeroDecimales(items[index].deuda);
          colorSub = Colors.red[300];
        } else if (adelanto) {
          subtitulo =
              'Adelantos: ' + formatearNumeroDecimales(items[index].adelanto);
          colorSub = Colors.blue[300];
        } else
          subtitulo = 'Al Día';

        return ListTile(
          /*Detalle*/
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                items[index].detalle,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5, right: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: loggedModel.getUser.idTipo == 1,
                  child: _VerMas(
                    idCredito: items[index].idCredito,
                  ),
                ),
                Text(
                  subtitulo,
                  style: TextStyle(
                    color: colorSub,
                    fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          /*Total pago*/
          trailing: Text(
            formatearNumeroDecimales(items[index].monto),
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      itemCount: items.length,
    );
  }
}

class _Total extends StatelessWidget {
  final List<TicketItem> items;
  _Total({this.items});
  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    double total = 0;
    items.forEach((element) {
      total += element.monto;
    });
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(),
        ),
      ),
      height: 60,
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Pagado',
            style: TextStyle(
                shadows: [
                  const BoxShadow(
                    color: Colors.black54,
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                letterSpacing: 5),
          ),
          Text(
            formatearNumeroDecimales(total),
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeBlockHorizontal * 5,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerMas extends StatelessWidget {
  final int idCredito;

  _VerMas({this.idCredito});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: idCredito > 0,
      child: Container(
        height: 22,
        width: 90,
        padding: EdgeInsets.only(top: 2, right: 5),
        child: OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.red),
          ),
          splashColor: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/mis_compras_detalle',
              arguments: {'idCredito': idCredito},
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Ver más',
                style: TextStyle(fontSize: 10),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 10, color: Theme.of(context).accentColor),
            ],
          ),
        ),
      ),
    );
  }
}
