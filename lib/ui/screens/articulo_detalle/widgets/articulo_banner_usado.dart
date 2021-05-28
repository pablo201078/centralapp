import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class ArticuloBannerUsado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10, top: 10),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          //  color: Colors.blueAccent.withOpacity(0.6),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 0.4, color: Theme.of(context).primaryColor),
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.9),
              Colors.lightBlueAccent.withOpacity(0.9),
              Colors.blueAccent.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              'Producto USADO',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
