import 'package:centralApp/logic/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotonWhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialButton(
      elevation: 10.0,
      child: Icon(
        MaterialCommunityIcons.whatsapp,
        size: 60.sp,
        color: Colors.green,
      ),
      onPressed: () {
        contactoWhatsApp(context);
      },
    );
  }
}
