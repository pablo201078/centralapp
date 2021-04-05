import 'package:flutter/material.dart';
import '../utils.dart';

class ArticuloBannerOferta extends StatelessWidget {

  final double angulo;

  ArticuloBannerOferta({Key key, @required this.angulo});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: this.angulo,
      child: Chip(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide( width: 0.4,color: Theme.of(context).primaryColor),
        ),
        elevation: 5,
        label: Text('OFERTA',
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 2.6,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white.withOpacity(0.9),
      ),
    );
  }
}
