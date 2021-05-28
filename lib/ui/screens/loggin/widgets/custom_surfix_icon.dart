import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:centralApp/utils.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        color: Colors.white,
        height: getProportionateScreenWidth(18),
      ),
    );
  }
}

class CustomSurffixIcon2 extends StatelessWidget {
  const CustomSurffixIcon2({
    Key key,
    @required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: getProportionateScreenWidth(20),
      ),
    );
  }
}
