import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumeracionImagen extends StatelessWidget {
  final String texto;
  final double top;
  final double left;

  NumeracionImagen(
      {Key key, @required this.texto, @required this.top, @required this.left});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.top,
      left: this.left,
      child: Container(
        width: 0.13.sw,
        height: 0.025.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey.withOpacity(0.3), //Colors.grey.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            texto,
            style: TextStyle(fontSize: 13.sp),
          ),
        ),
      ),
    );
  }
}
