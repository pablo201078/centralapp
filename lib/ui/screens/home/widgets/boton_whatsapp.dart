import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

class BotonWhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UsuarioBloc loggedModel =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);
    return MaterialButton(
      elevation: 10.0,
      child: Icon(
        MaterialCommunityIcons.whatsapp,
        size: 60.sp,
        color: Colors.green,
      ),
      onPressed: () {
        loggedModel.contactoWhatsApp();
      },
    );
  }
}
