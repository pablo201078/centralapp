import 'package:centralApp/logic/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../../constantes.dart';
import '../../../utils.dart';
import 'boton_ayuda.dart';
import 'boton_sms.dart';
import 'custom_surfix_icon.dart';
import 'default_button.dart';
import 'form_error.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/models/scoped/logged_model.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 15.0),
          SignForm(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2.0),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: ColumnaSolicitadClave(),
          ),
        ],
      ),
    );
  }
}

class ColumnaSolicitadClave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BotonSms(),
          Text(
            '(*) Solicitud de Contraseña por SMS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical *3.0),
          BotonAyuda(),
          Text(
            'Solicitar Ayuda',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          // SizedBox(height: SizeConfig.safeBlockVertical * 5.00),
          /*Text(
                'Solicita tu Contraseña por WhatsApp',
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BotonWhatsApp(),
              ),*/
        ],
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String dni;
  String password;
  bool _cargando = false;
  bool _mostrarPw = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final LoggedModel modelo =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDniFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildPasswordFormField(modelo.clave),
          Text(
            '(*) Solicitar contraseña',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(15)),
          DefaultButton(
            text: "Ingresar",
            cargando: _cargando,
            press: () async {
              if (_cargando) return;
              if (_formKey.currentState.validate()) {
                setState(() {
                  _cargando = true;
                });
                _formKey.currentState.save();
                await validarUsuario(dni, password, context);
                setState(() {
                  _cargando = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField(String clave) {
    return TextFormField(
      obscureText: !_mostrarPw,
      maxLength: 8,
      initialValue: clave,
      maxLengthEnforced: true,
      style: TextStyle(color: Colors.white),
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contraseña",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _mostrarPw = !_mostrarPw;
            });
          },
          //  child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          child: CustomSurffixIcon2(
              icon: _mostrarPw
                  ? Icons.remove_red_eye
                  : MaterialCommunityIcons.eye_off),
        ),
        border: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        errorBorder: outlineInputBorder(),
        focusedErrorBorder: outlineInputBorder(),
      ),
    );
  }

  TextFormField buildDniFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 8,
      style: TextStyle(color: Colors.white),
      onSaved: (newValue) => dni = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDniNullError);
        }
        /* else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }*/
        return null;
      },
      validator: (value) {
        if (value.isEmpty || value.length < 8) {
          addError(error: kDniNullError);
          return "";
        }

        /*else if (!dniValidatorRegExp.hasMatch(value)) {
          addError(error: kDniNullError);
          return "";
        }*/
        return null;
      },
      decoration: InputDecoration(
          labelText: "Número de DNI sin puntos ni espacios.",
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          //hintText: "Ingrese su numero de Dni",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
          border: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          enabledBorder: outlineInputBorder(),
          errorBorder: outlineInputBorder(),
          focusedErrorBorder: outlineInputBorder()),
    );
  }
}
