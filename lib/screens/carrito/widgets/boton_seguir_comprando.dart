import 'package:flutter/material.dart';
import '../../../utils.dart';

class BotonSeguirComprando extends StatelessWidget {

  final int ancho;

  BotonSeguirComprando({Key key, @required this.ancho });

  @override
  Widget build(BuildContext context) {
    void click() async {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: click,
        height: SizeConfig.safeBlockVertical * 5.5,
        elevation: 0.0,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * this.ancho,
          child: Center(
            child: Text(
              'Seguir Comprando',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.safeBlockHorizontal * 3.0,
              ),
            ),
          ),
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.circular(7.0)),
      ),
    );
  }
}
