import 'package:centralApp/constantes.dart';
import 'package:flutter/material.dart';
import 'caption.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(BuildContext context,
    {String title, bool drawer, List<Widget> actions}) {
  return AppBar(
    title: Caption(
      texto: title,
    ),
    centerTitle: false,
    leading: drawer ?? false ? _Leading() : null,
    flexibleSpace: (Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
            Theme.of(context).accentColor,
          ],
        ),
      ),
    )),
    actions: actions,
  );
}

class _Leading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: Icon(
        Icons.menu,
        size: sizeActions,
        color: Colors.white,
      ),
    );
  }
}
