import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
              size: 28.sp,
            )
          : badge,
      trailing: this.trailing,
      title: Text(
        title,
        style: TextStyle(
            fontSize:  15.sp,
            color: Theme.of(context).accentColor),
      ),
    );
  }
}
