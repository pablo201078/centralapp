import 'package:centralApp/data/repositories/compras.dart';
import 'package:centralApp/data/models/credito.dart';
import 'package:centralApp/logic/creditos.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:centralApp/ui/screens/deuda_vencida/widgets/deuda_vencida_body.dart';
import 'package:centralApp/ui/screens/deuda_vencida/widgets/deuda_vencida_lista_vacia.dart';
import 'package:centralApp/ui/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DeudaVencida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UsuarioBloc loggedModel =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);

    return ScopedModel<CreditosModel>(
      model: CreditosModel(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: 'Deuda Vencida',
          actions: [],
        ),
        body: _Body(idCliente: loggedModel.getUser.idCliente),
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
    _futuro = comprasRepo.getCreditosDeuda(widget.idCliente);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Credito>>(
      future: _futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SinConexion();
        }

        if (!snapshot.hasData)
          return LoadingList(
            itemsCount: 7,
          );

        if (snapshot.data.isEmpty)
          return DeudaVencidaListaVacia();
        else {
          return DeudaVencidaBody(lista: snapshot.data);
        }
      },
    );
  }
}
