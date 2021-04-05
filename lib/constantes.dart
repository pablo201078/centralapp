import 'package:centralApp/utils.dart';
import 'package:flutter/material.dart';

const String URL = 'http://mutualamacar.no-ip.org/app/';

const String txtIniciarSesion = 'Tenes que ser Socio de la Mutual para usar esta opción';
const String txtEliminasteDelCarrito = 'Eliminaste del Carrito';



// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp dniValidatorRegExp =
RegExp(r"^(\d{2}\{1}\d{3}\\d{3})|(\d{2}\s{1}\d{3}\s\d{3})$");
const String kDniNullError = "Por favor ingreso su nro de Dni";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Por favor ingrese su clave";
const String kShortPassError = "Contraseña muy corta";


final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: Colors.white),
  );
}


const sizeActions = 29.0;


