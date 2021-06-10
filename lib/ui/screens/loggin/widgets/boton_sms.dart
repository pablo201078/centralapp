import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:centralApp/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class BotonSms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UsuarioBloc loggedModel =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);
    return InkWell(
      child: Icon(
        MaterialCommunityIcons.message_outline,
        size: SizeConfig.safeBlockHorizontal * 15.0,
        color: Colors.white,
      ),
      onTap: () {
        loggedModel.enviarSms();
      },
    );
  }
}
