import 'package:centralApp/api/ticket.dart';
import 'package:centralApp/models/ticket_item.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:centralApp/screens/ticket/widgets/ticket_caja.dart';
import 'package:centralApp/utils.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/elevated_card.dart';
import 'package:centralApp/widgets/gradient_back.dart';
import 'package:centralApp/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Ticket extends StatelessWidget {
  // int idCliente;

  //Ticket({this.idCliente});

  @override
  Widget build(BuildContext context) {
    //  final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    //this.idCliente = arguments['idCliente'];
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(context, title: 'Ticket de Pago', actions: []),
      body: _Body(
        idCliente: model.getUser.idCliente,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int idCliente;
  _Body({this.idCliente});
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  Future<List<TicketItem>> _futuro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futuro = getTicket(widget.idCliente);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBack(),
        FutureBuilder<List<TicketItem>>(
          future: _futuro,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (!snapshot.hasData) return _Cargando();
            if (snapshot.data.length > 0)
              return _Detalle(items: snapshot.data);
            else
              return _NoTicket();
          },
        ),
      ],
    );
  }
}

class _NoTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No hay Tickets para mostrarte.',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _Cargando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        _Titulo(
          fecha: '........',
          dia: '',
          hora: '00:00',
        ),
        //   _Logo(),
        SizedBox(
          height: 20,
        ),
        ElevatedCard(
          padding: EdgeInsets.only(top: 50),
          shadowColor: Theme.of(context).primaryColor,
          height: SizeConfig.safeBlockVertical * 60,
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
          child: LoadingList(
            itemsCount: 4,
          ),
        ),
      ],
    );
  }
}

class _Detalle extends StatelessWidget {
  List<TicketItem> items;
  _Detalle({this.items});

  @override
  Widget build(BuildContext context) {
    /*Future.delayed(
      Duration.zero,
      () {
        if (items[0].puntos > 0)
          showSnackBar(context, 'Hoy Acumulaste ${items[0].puntos} Puntos',
              Colors.green);
      },
    );*/

    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        _Titulo(fecha: items[0].fecha, dia: items[0].dia, hora: items[0].hora),
        //   _Logo(),
        SizedBox(
          height: 20,
        ),
        TicketCaja(items: items),
        SizedBox(
          height: 20,
        ),
        //_Puntos(puntos: items[0].puntos),
      ],
    );
  }
}

class _Titulo extends StatelessWidget {
  final String fecha;
  final String dia;
  final String hora;

  _Titulo({this.fecha, this.dia, this.hora});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Logo(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dia,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                fecha,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Hora:  ' + hora ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 3,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/imagenes/amacar02.png',
        width: SizeConfig.safeBlockHorizontal * 30,
      ),
    );
  }
}
