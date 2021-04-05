import 'package:flutter/material.dart';

import '../../../utils.dart';

class NumeracionImagen extends StatelessWidget {
  final String texto;
  final double top;
  final double left;

  NumeracionImagen(
      {Key key, @required this.texto, @required this.top, @required this.left});

  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: this.top,
      left: this.left,
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 8.9,
        height: SizeConfig.safeBlockVertical * 2.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey.withOpacity(0.3), //Colors.grey.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            texto,
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 2.6),
          ),
        ),
      ),
    );
  }
}
