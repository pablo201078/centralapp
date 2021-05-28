import 'package:flutter/material.dart';

class Caption extends StatelessWidget {
  final String texto;
  final double size;

  Caption({
    Key key,
    this.texto,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.texto,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          shadows: [
            const BoxShadow(
              color: Colors.black54,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: const Offset(3.0, 3.0),
            ),
          ],
        ),
      ),
    );
  }
}
