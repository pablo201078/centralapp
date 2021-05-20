import 'package:centralApp/models/scoped/logged_model.dart';
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

    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

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
        style: TextStyle(fontSize: 20.sp),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/loggin');
      },
    );
  }
}
