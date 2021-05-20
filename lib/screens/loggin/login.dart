import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:centralApp/screens/loggin/widgets/login_manual_body.dart';
import 'package:centralApp/screens/loggin/widgets/scanner_body.dart';
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
//  bool android6 = false;

/*
  void getAndroidVersion2() async {
    var rta = await getAndroidVersion();
    print('version: $rta');
    if (rta == '6.0')
      setState(() {
        android6 = true;
      });
  }
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getAndroidVersion2();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Platform.isAndroid
        ? //!android6
        Scaffold(
            bottomNavigationBar: BubbleBottomBar(
              opacity: .2,
              currentIndex: _tipoLogin,
              onTap: (value) {
                setState(() {
                  _tipoLogin = value;
                });
              },
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              elevation: 8,
              fabLocation: BubbleBottomBarFabLocation.end, //new
              // hasNotch: true, //new
              hasInk: true, //new, gives a cute ink effect
              inkColor:
                  Colors.black12, //optional, uses theme color if not specified
              items: <BubbleBottomBarItem>[
                BubbleBottomBarItem(
                  backgroundColor: Colors.deepPurple,
                  icon: Icon(
                    FontAwesomeIcons.qrcode,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    FontAwesomeIcons.qrcode,
                    color: Colors.deepPurple,
                  ),
                  title: Text("Scanear DNI"),
                ),
                BubbleBottomBarItem(
                  backgroundColor: Colors.green,
                  // icon: FaIcon(FontAwesomeIcons.userCheck, color: Colors.black,),
                  icon: Icon(
                    Icons.add_circle_outline_sharp,
                    color: Colors.grey,
                    size: 35,
                  ),
                  activeIcon: Icon(
                    Icons.format_align_center,
                    color: Colors.green,
                  ),
                  title: Text("Con Clave"),
                )
              ],
            ),
            body: _tipoLogin == 0 ? ScannerBody() : LoginManualBody(),
          )
        : Scaffold(
        resizeToAvoidBottomInset:true,
            body: LoginManualBody(),
          );
  }
}
