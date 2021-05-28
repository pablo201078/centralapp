import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class SinConexion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/imagenes/offline.png',
            width: SizeConfig.safeBlockHorizontal * 60,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Parece que no hay Internet!', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
