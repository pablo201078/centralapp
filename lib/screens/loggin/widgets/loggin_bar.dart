import 'package:flutter/material.dart';

import '../../../utils.dart';

class LogginBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 10, top: 37),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: SizeConfig.blockSizeHorizontal * 9.0,
            splashColor: Colors.white,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              'Iniciar Sesión',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
