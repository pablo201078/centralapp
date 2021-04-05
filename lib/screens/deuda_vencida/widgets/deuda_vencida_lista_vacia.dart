import 'package:flutter/material.dart';

import '../../../utils.dart';

class DeudaVencidaListaVacia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Estás al Día',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: SizeConfig.safeBlockHorizontal * 7),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.check, size: 60, color: Colors.green),
        ],
      ),
    );
  }
}
