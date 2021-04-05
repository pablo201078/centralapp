import 'package:centralApp/models/usuario.dart';
import 'package:centralApp/screens/renovacion_efectivo/widgets/renovacion_efectivo_opcion.dart';
import 'package:centralApp/screens/renovacion_efectivo/widgets/renovacion_efectivo_titulo.dart';
import 'package:centralApp/utils.dart';
import 'package:centralApp/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:centralApp/logic/efectivo.dart';

class RenovacionEfectivo extends StatelessWidget {
  Vencimiento vencimiento;

  RenovacionEfectivo({this.vencimiento});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.vencimiento = arguments['vencimiento'];

    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Ayuda Económica',
        actions: [],
      ),
      body: Column(
        children: [
          RenovacionEfectivoTitulo(txt: 'Solicitá  EFECTIVO  Ahora ! ! ! '),
          Divider(color: Theme.of(context).accentColor),
          Expanded(
            child: _Opciones(
              vencimiento: vencimiento,
            ),
          ),
        ],
      ),
    );
  }
}

class _Opciones extends StatefulWidget {
  Vencimiento vencimiento;

  _Opciones({this.vencimiento});

  @override
  __OpcionesState createState() => __OpcionesState();
}

class __OpcionesState extends State<_Opciones> {
  bool _cargando1 = false;
  bool _cargando2 = false;

  @override
  Widget build(BuildContext context) {
    LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RenovacionEfectivoOpcion(
                  txt: 'Quiero ${widget.vencimiento.monto}',
                  click: () async {
                    if (!_cargando1) {
                      setState(() {
                        _cargando1 = true;
                      });
                      await renovarEfectivo(
                          context,
                          loggedModel.getUser.idCliente,
                          widget.vencimiento.monto);
                      setState(() {
                        _cargando1 = false;
                      });
                    }
                  },
                  cargando: _cargando1,
                  alto: SizeConfig.safeBlockHorizontal * 18, //90 * 0.20,
                  coloresGradiente: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RenovacionEfectivoOpcion(
                  txt: 'Contactar Asesor',
                  click: () async {
                    if (!_cargando2) {
                      setState(() {
                        _cargando2 = true;
                      });
                      await contactarAsesor(
                          context, loggedModel.getUser.idCliente);
                      setState(() {
                        _cargando2 = false;
                      });
                    }
                  },
                  cargando: _cargando2,
                  alto: SizeConfig.safeBlockHorizontal * 90 * 0.20,
                  coloresGradiente: [
                    Colors.black54,
                    Colors.black54,
                    Colors.black12,
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: RenovacionEfectivoOpcion(
                txt: 'Por Ahora no',
                cargando: false,
                click: Navigator.of(context).pop,
                alto: SizeConfig.safeBlockHorizontal * 90 * 0.18,
                coloresGradiente: [
                  Colors.redAccent,
                  Colors.red,
                  Colors.white,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
