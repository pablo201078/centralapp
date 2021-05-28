import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class UsadosListaVacia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.remove_shopping_cart, size: 60, color: Colors.red),
          Text(
            'No se encontraron resultados',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: SizeConfig.safeBlockHorizontal * 7),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
