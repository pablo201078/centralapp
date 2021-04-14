import 'package:auto_size_text/auto_size_text.dart';
import 'package:centralApp/logic/varios.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class TarjetaDorso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        gradient: LinearGradient(colors: [
          Colors.indigo,
          Colors.blueAccent,
          Colors.lightBlue,
        ]),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 10,
            child: Container(
              width: SizeConfig.safeBlockHorizontal * 35,
              child: Image.asset(
                'assets/imagenes/amacar02.png',
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 30,
            child: GestureDetector(
              onTap: llamar0800,

              child: Column(
                children: [
                  Text(
                    'Línea atención a Socios',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.0),
                  ),
                  Text(
                    '0800 222 1825',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.call,
                      size: 30,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  Text(
                    'Llamar',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Matricula N° 2827',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.0),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 0.3,
                ),
                AutoSizeText(
                  'Mutual A.M.A.C.A.R ',
                  //Sarmiento y Güemes - Roberts (Buenos Aires) Argentina.',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 3.0),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 0.3,
                ),
                FittedBox(
                  child: AutoSizeText(
                    'Sarmiento y Güemes - Roberts Buenos Aires, Argentina',
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 3.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
