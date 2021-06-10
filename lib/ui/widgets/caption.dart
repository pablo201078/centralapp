import 'package:flutter/material.dart';

class Caption extends StatelessWidget {
  final String texto;

  Caption({
    Key key,
    @required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.texto,
        style: Theme.of(context).textTheme.headline6.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: Colors.white,
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
