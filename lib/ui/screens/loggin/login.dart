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
            bottomNavigationBar: BottomNavyBar /*BubbleBottomBar*/ (
              // opacity: .2,
              selectedIndex: _tipoLogin,
              onItemSelected: (value) {
                setState(() {
                  _tipoLogin = value;
                });
              },
              //borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              //elevation: 8,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeInToLinear,
              // fabLocation: BubbleBottomBarFabLocation.end, //new
              // hasNotch: true, //new
              //  hasInk: true, //new, gives a cute ink effect
              //  inkColor:    Colors.black12, //optional, uses theme color if not specified
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  // backgroundColor: Colors.deepPurple,
                  icon: Icon(
                    FontAwesomeIcons.qrcode,
                    color: Theme.of(context).primaryColor,
                  ),
                  /*  activeIcon: Icon(
                    FontAwesomeIcons.qrcode,
                    color: Colors.deepPurple,
                  ),*/
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
                  /*activeIcon: Icon(
                    Icons.format_align_center,
                    color: Colors.green,
                  ),*/
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
