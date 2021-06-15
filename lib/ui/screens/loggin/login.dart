import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:centralApp/ui/screens/loggin/widgets/login_manual_body.dart';
import 'package:centralApp/ui/screens/loggin/widgets/scanner_body.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

class Loggin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogginState();
  }
}

class LogginState extends State<Loggin> {
  int _tipoLogin = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Platform.isAndroid
        ? Scaffold(
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: _tipoLogin,
              onItemSelected: (value) {
                setState(() {
                  _tipoLogin = value;
                });
              },
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeInToLinear,
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(
                    FontAwesomeIcons.qrcode,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                  title: Text("Scanear DNI"),
                ),
                BottomNavyBarItem(
                  activeColor: Colors.green,
                  textAlign: TextAlign.center,
                  icon: Icon(
                    Icons.add_circle_outline_sharp,
                    color: Colors.grey,
                    //size: 35,
                  ),
                  title: Text("Con Clave"),
                )
              ],
            ),
            body: _tipoLogin == 0 ? ScannerBody() : LoginManualBody(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: LoginManualBody(),
          );
  }
}
