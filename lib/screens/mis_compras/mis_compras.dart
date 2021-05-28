import 'package:centralApp/data/repositories/compras.dart';
import 'package:centralApp/data/models/credito.dart';
import 'package:centralApp/data/scoped/creditos.dart';
import 'package:centralApp/data/scoped/logged_model.dart';
import 'package:centralApp/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/screens/mis_compras/widgets/mis_compras_body.dart';
import 'package:centralApp/screens/mis_compras/widgets/mis_compras_lista_vacia.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:centralApp/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MisCompras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CreditosModel>(
      model: CreditosModel(),
      child: _Scaffold(),
    );
  }
}

class _Scaffold extends StatefulWidget {
  @override
  __ScaffoldState createState() => __ScaffoldState();
}

class __ScaffoldState extends State<_Scaffold> {
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CreditosModel creditosModel =
        ScopedModel.of<CreditosModel>(context, rebuildOnChange: false);

    setState(() {
      _index = creditosModel.tipo - 1;
    });
    //creditosModel.tipo = 1 ;

    LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Mis Compras',
        actions: [],
      ),
      body: _Body(idCliente: loggedModel.getUser.idCliente),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text('Actuales'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('Anteriores'),
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: (index) {
          creditosModel.tipo = index + 1;
          setState(() {
            _index = index;
          });
        },
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
  Future<List<Credito>> _futuro;
  var comprasRepo = ComprasRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futuro = comprasRepo.getCreditos(widget.idCliente);
  }

  @override
  Widget build(BuildContext context) {
    CreditosModel creditosModel =
        ScopedModel.of<CreditosModel>(context, rebuildOnChange: false);

    return FutureBuilder<List<Credito>>(
      future: _futuro,
      builder: (context, snapshot) {
        //if ( snapshot.data  == null) return LoadingList(itemsCount: 5,);

        if (snapshot.hasError) {
          return SinConexion();
        }

        if (!snapshot.hasData)
          return LoadingList(
            itemsCount: 7,
          );

        if (snapshot.data.isEmpty)
          return MisComprasListaVacia();
        else {
          creditosModel.creditos = snapshot.data;
          return MisComprasBody();
        }
      },
    );
  }
}
