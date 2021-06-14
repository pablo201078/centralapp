import 'package:centralApp/data/models/usuario.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class BotonCompartirQr extends StatefulWidget {
  final Usuario usuario;
  final screenshotController;

  BotonCompartirQr({this.usuario, this.screenshotController});

  @override
  _BotonCompartirQrState createState() => _BotonCompartirQrState();
}

class _BotonCompartirQrState extends State<BotonCompartirQr> {
  bool _cargando = false;

  @override
  Widget build(BuildContext context) {
    final UsuarioBloc usuarioBloc =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: MaterialButton(
        onPressed: () async {
          if (_cargando) return;
          setState(() {
            _cargando = true;
          });
          await usuarioBloc.compartirQr(
            widget.screenshotController,
            context,
          );
          setState(() {
            _cargando = false;
          });
        },
        child: Container(
          height: SizeConfig.safeBlockVertical * 6,
          width: SizeConfig.safeBlockHorizontal * 70,
          child: Center(
            child: !_cargando
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Compartir mi QR',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.share,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
          ),
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
