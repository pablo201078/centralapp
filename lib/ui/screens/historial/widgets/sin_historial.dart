import 'package:centralApp/widgets/boton_empezar_a_comprar.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';


class SinHistorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text(
            "Todavia no viste ningún producto.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: SizeConfig.safeBlockHorizontal * 5.0),
          ),
          SizedBox(height: 20,),
          BotonEmpezarAComprar()
        ]
      ),
    );
  }
}
