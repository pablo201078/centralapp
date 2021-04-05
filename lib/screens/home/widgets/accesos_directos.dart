import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:centralApp/models/scoped/logged_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../utils.dart';

class CircleButton extends StatelessWidget {
  final String caption;
  final IconData icon;
  final Color shadowColor;
  final VoidCallback onPress;

  CircleButton(
      {Key key,
      @required this.caption,
      @required this.icon,
      @required this.shadowColor,
      @required this.onPress});
  void onPressedButton() {}

  Widget boton(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 13,
      height: SizeConfig.safeBlockHorizontal * 13,
      child: IconButton(
        icon: Icon(
          this.icon,
          size: SizeConfig.safeBlockHorizontal * 7.5,
        ),
        color: Theme.of(context).primaryColor,
        onPressed: onPress,
        splashColor: Theme.of(context).accentColor,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 5.0,
            offset: const Offset(3.0, 3.0),
            spreadRadius: 1.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.safeBlockHorizontal * 19,
      child: Column(
        children: [
          boton(context),
          SizedBox(
            height: 5,
          ),
          AutoSizeText(
            this.caption,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8, //SizeConfig.safeBlockHorizontal * 2.6,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class AccesosDirectos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

    // TODO: implement build
    return Container(
      height: SizeConfig.safeBlockVertical * 15,
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, right: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleButton(
            caption: 'Historial',
            shadowColor: Theme.of(context).accentColor,
            icon: Icons.history,
            onPress: () {
              if (model.isLogged && model.getUser.idTipo == 1 )
                Navigator.pushNamed(context, '/historial',
                    arguments: {'idCliente': model.getUser.idCliente});
            },
          ),

          CircleButton(
            caption: 'Hogar',
            shadowColor: Theme.of(context).accentColor,
            icon: Icons.home,
            onPress: () {
              Navigator.pushNamed(context, '/hogar', arguments: {
                'idCliente': model.isLogged ? model.getUser.idCliente : 0
              });
            },
          ),
          CircleButton(
            caption: 'Comercial',
            shadowColor: Theme.of(context).primaryColor,
            icon: Icons.build,
            onPress: () {
              Navigator.pushNamed(context, '/equipamiento_comercial',
                  arguments: {
                    'idCliente': model.isLogged ? model.getUser.idCliente : 0
                  });
            },
          ),
          CircleButton(
            caption: '2da Mano',
            shadowColor: Theme.of(context).primaryColor,
            icon: FontAwesomeIcons.recycle,
            //    icon: MaterialCommunityIcons.fridge,
            onPress: () {
              Navigator.pushNamed(
                context,
                '/usados',
              );
            },
          ),
          Badge(
            showBadge: model.favoritosCantidad != 0,
            position: BadgePosition.topEnd(top: -3, end: 5),
            badgeColor: Theme.of(context).accentColor,
            // badgeColor: Colors.grey,
            elevation: 0,
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            badgeContent: Text(
              //isLogged ? enCarrito.toString() : '0',
              model.favoritosCantidad.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: CircleButton(
                caption: 'Favoritos',
                shadowColor: Theme.of(context).accentColor,
                icon: Icons.favorite_border,
                onPress: () {
                  if (model.isLogged  && model.getUser.idTipo == 1 )
                    Navigator.pushNamed(context, '/favoritos', arguments: {
                      'idCliente': model.isLogged ? model.getUser.idCliente : 0
                    });
                }),
          ),
        ],
      ),
    );
  }
}
