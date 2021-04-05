import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';

class CustomListTile extends StatelessWidget {
  IconData icon;
  String title;
  VoidCallback onTap;
  String heroTag;
  Color iconColor;
  Widget trailing;
  Badge badge;

  CustomListTile(
      {Key key,
      this.heroTag,
      this.iconColor,
      this.trailing,
      this.badge,
      @required this.icon,
      @required this.title,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ListTile(
      onTap: onTap,
      dense: false,
      leading: badge == null
          ? Icon(
              icon,
              color: iconColor != null ? iconColor : Colors.grey,
              size: SizeConfig.blockSizeHorizontal * 8.6,
            )
          : badge,
      trailing: this.trailing,
      title: Text(
        title,
        style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 3.6,
            color: Theme.of(context).accentColor),
      ),
    );

    /*   return Container(
      height: 33,
      decoration: BoxDecoration(
          //   border: Border( bottom: BorderSide( color: Colors.grey.shade400 ))
          ),
      margin: EdgeInsets.only(left: 15, right: 10, top: 15),
      child: InkWell(
        onTap: onTap,
        splashColor: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                heroTag != null
                    ? Hero(
                        tag: heroTag,
                        child: Icon(
                          icon,
                          color: iconColor != null ? iconColor : Colors.grey,
                          size: SizeConfig.blockSizeHorizontal * 8.6,
                        ),
                      )
                    : Icon(
                        icon,
                        color: iconColor != null ? iconColor : Colors.grey,
                        size: SizeConfig.blockSizeHorizontal * 8.6,
                      ),
                Container(
                  //padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(left: 20),
                  child: Text(title,
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                          color: Theme.of(context).accentColor)),
                ),
              ],
            ),
            Icon(Icons.arrow_right,
                color: Theme.of(context).primaryColor,
                size: SizeConfig.blockSizeHorizontal * 10.0)
          ],
        ),
      ),
    );*/
  }
}
