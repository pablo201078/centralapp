import 'package:centralApp/widgets/gradient_back.dart';
import 'package:flutter/material.dart';
import 'loggin_bar.dart';
import 'login_form.dart';

class LoginManualBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBack(),
        LoginForm(),
        LogginBar(),
      ],
    );
  }
}
