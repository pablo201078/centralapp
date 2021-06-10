import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotonLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BotonLoginState();
}

class _BotonLoginState extends State<BotonLogin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final UsuarioBloc model =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: true);

    if (model.isLogged) {
      return Container();
    }
    return FloatingActionButton.extended(
      elevation: 10.0,
      tooltip: 'Abre la Cámara para identificarte como Socio',
      backgroundColor: Theme.of(context).accentColor,
      icon: Icon(MaterialCommunityIcons.qrcode),
      label: Text(
        'Iniciar Sesión',
        style: Theme.of(context).textTheme.headline6,
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/loggin');
      },
    );
  }
}
