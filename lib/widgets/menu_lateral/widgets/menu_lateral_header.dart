import 'package:flutter/material.dart';

class MenuLateralHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DrawerHeader(
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/scanner');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                margin: EdgeInsets.only(bottom: 8),
                //  decoration: BoxDecoration(
                //   image: DecorationImage(image: AssetImage('assets/qr.png')),

                //),
              ),
            ],
          )),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ]),
      ),
    );
  }
}
