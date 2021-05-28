import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';


class RenovacionEfectivoTitulo extends StatelessWidget {
  final String txt;
  RenovacionEfectivoTitulo({this.txt});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 15),
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 90.0,
        height: SizeConfig.blockSizeVertical * 8.0,
       /* decoration: BoxDecoration(
          //color: Theme.of(context).accentColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(width: 0.6),
        ),*/
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                letterSpacing: 1,
                color: Theme.of(context).primaryColor,
                fontSize: SizeConfig.blockSizeHorizontal * 5.2,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
