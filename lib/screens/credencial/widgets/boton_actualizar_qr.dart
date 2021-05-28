import 'package:flutter/material.dart';
import 'package:centralApp/data/scoped/logged_model.dart';
import '../../../utils.dart';

class BotonActualizarQr extends StatelessWidget {
  final LoggedModel usuario;
  final bool actualizando;
  VoidCallback click;

  BotonActualizarQr({this.usuario, this.actualizando, this.click});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: click,
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 80,
        height: SizeConfig.safeBlockVertical * 6,
        child: Center(
          child: !actualizando
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Actualizar CODIGO QR',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                      ),
                    ),
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.redAccent,
                        size: SizeConfig.safeBlockVertical * 3.5),
                  ],
                )
              : CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
