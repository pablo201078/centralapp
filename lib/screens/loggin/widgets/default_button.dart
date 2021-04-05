import 'package:flutter/material.dart';

import '../../../utils.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({Key key, this.text, this.press, this.cargando})
      : super(key: key);
  final String text;
  final Function press;
  final bool cargando;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17),),
        color: Theme.of(context).accentColor,
        onPressed: press,
        child: cargando
            ? CircularProgressIndicator( backgroundColor: Colors.white,)
            : Text(
                text,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
