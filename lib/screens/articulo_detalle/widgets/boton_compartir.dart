import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BotonCompartir extends StatelessWidget {
  final String link;

  BotonCompartir({Key key, @required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey.withOpacity(0.3), //Colors.grey.withOpacity(0.5),
      ),
      alignment: Alignment.center,
      child: GestureDetector(
        // child: Icon(Icons.share, color: Colors.black54, size: 20,),
        child: Icon(
          Icons.share,
          color: Colors.black,
          size: 20,
        ),
        onTap: () {
          Share.share('Mira este producto: ${link} ');
        },
      ),
    );
  }
}
