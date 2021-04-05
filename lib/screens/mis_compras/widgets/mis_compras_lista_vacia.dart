
import 'package:flutter/material.dart';

import '../../../utils.dart';

class MisComprasListaVacia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.remove_shopping_cart, size: 60, color: Colors.red),
          Text(
            'Todavia no compraste nada',
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
