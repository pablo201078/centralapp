import 'package:auto_size_text/auto_size_text.dart';
import 'package:centralApp/models/scoped/usados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';

class UsadosListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
                color: Theme.of(context).accentColor
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Boton(txt: 'Destacado', icon: Icons.check, tipo: 1),
          _Boton(txt: 'Hogar', icon: Icons.home, tipo: 2),
          _Boton(
              txt: 'Comercial',
              icon: MaterialCommunityIcons.toolbox_outline,
              tipo: 3),
        ],
      ),
    );
  }
}

class _Boton extends StatelessWidget {
  final String txt;
  final IconData icon;
  final int tipo;

  _Boton({this.txt, this.icon, this.tipo});
  @override
  Widget build(BuildContext context) {
    UsadosModel usadosModel =
        ScopedModel.of<UsadosModel>(context, rebuildOnChange: true);

    return GestureDetector(
      onTap: () {
        usadosModel.tipo = tipo;
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 75,
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),

        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(6),
            color: tipo == usadosModel.tipo
                ? Theme.of(context).accentColor.withOpacity(0.6)
                : Colors.transparent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: tipo == usadosModel.tipo ? 40 : 30,
              color: tipo == usadosModel.tipo
                  ? Colors.white
                  : Theme.of(context).accentColor,
            ),
            AutoSizeText(
              txt,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: tipo != usadosModel.tipo
                    ? Theme.of(context).accentColor.withOpacity(0.6)
                    : Colors.white70,
                fontWeight: FontWeight.normal,
                fontSize: tipo == usadosModel.tipo ? 12 : 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
