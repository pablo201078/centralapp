import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class RenovacionEfectivoOpcion extends StatelessWidget {
  final String txt;
  final coloresGradiente;
  final double alto;
  final VoidCallback click;
  final bool cargando;

  RenovacionEfectivoOpcion(
      {this.txt, this.coloresGradiente, this.alto, this.click, this.cargando});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      splashColor: Colors.blueAccent,
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 90,
        height: alto,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cargando
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Text(
                      txt,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 5,
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontWeight: FontWeight.bold),
                    ),
              //Icon(icono, color: Colors.white, size: 30),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              offset: Offset(5, 5),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
          gradient: LinearGradient(
            colors: coloresGradiente,
          ),
        ),
      ),
    );
  }
}
