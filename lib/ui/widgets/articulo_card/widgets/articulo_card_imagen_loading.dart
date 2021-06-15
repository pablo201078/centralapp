import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticuloCardImagenLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.all(20.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Container(
          width: 60.0,
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              shape: BoxShape.rectangle,
              color: Colors.white),
        ),
      ),
    );
  }
}
