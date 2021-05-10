import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/usuario.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

//se usa solo en main.dart
Future<int> getIdCliente() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('isLogged') ?? false) {
    Usuario user = Usuario.fromJson(
      json.decode(
        prefs.getString('user'),
      ),
    );
    return user.idCliente;
  }
  return 0;
}

Future<String> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  } else
    return 'ios';
}

Future<String> getAndroidVersion() async {
  var deviceInfo = DeviceInfoPlugin();
  var androidDeviceInfo = await deviceInfo.androidInfo;
  return androidDeviceInfo.version.release;
}

final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
final formatCurrencyDec = NumberFormat.simpleCurrency(decimalDigits: 2);

String cambiarSimbolos(String txt) {
  return txt.replaceFirst('.', ',').replaceFirst(',', '.');
}

String formatearNumero(double value) {
  return cambiarSimbolos(formatCurrency.format(value));
}

String formatearNumeroDecimales(double value) {
  return cambiarSimbolos(formatCurrencyDec.format(value));
}

String formatearFecha(DateTime fecha) {
  return DateFormat('dd-MM-yyyy').format(fecha);
}

String formatearFechaStr(DateTime fecha) {
  String dia = DateFormat('EEEE').format(fecha);
  if (dia == 'Monday') dia = 'Lunes';
  if (dia == 'Tuesday') dia = 'Martes';
  if (dia == 'Wednesday') dia = 'Miércoles';
  if (dia == 'Thursday') dia = 'Jueves';
  if (dia == 'Friday') dia = 'Viernes';
  if (dia == 'Saturday') dia = 'Sábado';
  if (dia == 'Sunday') dia = 'Domingo';

  return '$dia  ${DateFormat('dd').format(fecha)}';
}


