import 'package:auto_size_text/auto_size_text.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../utils.dart';
import 'imagen_socio.dart';

class TarjetaFrente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        gradient: LinearGradient(colors: [
          Colors.indigo,
          Colors.blueAccent,
          Colors.lightBlue,
        ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Arriba(),
          _Abajo(),
        ],
      ),
    );
  }
}

class _Arriba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Socio(),
            _Logo(),
          ],
        ),
        Divider(
          color: Colors.white,
        ),
      ],
    );
  }
}

class _Socio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoggedModel modelo =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            modelo.getUser.nombre,
            maxLines: 1,
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                fontWeight: FontWeight.bold),
          ),
          Text('Socio Adherente   ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.0)),
          Text('N°:   ' + modelo.getUser.nroSocio,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.0)),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8.0, right: 20.0),
        width: SizeConfig.blockSizeHorizontal * 22.0,
        child: Image.asset(
            'assets/imagenes/amacar02.png') //Icon(Icons.account_circle, size: 80, color: Colors.white),
        );
  }
}

class _Abajo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoggedModel modelo =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImagenSocio(),
          Container(
            width: SizeConfig.safeBlockHorizontal * 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilaInfo(Icons.art_track, 'DNI ' + modelo.getUser.dni),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 0.4,
                ),
                _buildFilaInfo(Icons.location_on, modelo.getUser.comercio),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 0.4,
                ),
                _buildFilaInfo(
                  Icons.directions,
                  modelo.getUser.localidad.toUpperCase(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildFilaInfo(IconData iconData, String info) {
  return Row(
    children: [
      Icon(
        iconData,
        color: Colors.white,
        size: SizeConfig.safeBlockHorizontal * 7.0,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 45,
          child: AutoSizeText(
            info,
            maxLines: 1,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
