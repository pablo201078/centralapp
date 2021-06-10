import 'package:barcode_scan2/gen/protos/protos.pb.dart';
import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:centralApp/ui/screens/loggin/widgets/loggin_cargando.dart';
import 'package:centralApp/ui/widgets/gradient_back.dart';
import 'package:centralApp/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'loggin_bar.dart';

class ScannerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBack(),
        _Camara(),
        LogginBar(),
      ],
    );
  }
}

class _Camara extends StatefulWidget {
  @override
  __CamaraState createState() => __CamaraState();
}

class __CamaraState extends State<_Camara> {
  //bool _camState;
  bool _showLoading;
  String barcode;

  void codigoLeido(String code, BuildContext context) async {
    final UsuarioBloc modelo =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: false);
    await modelo.validarUsuarioScan(code, context);
    setState(() {
      _showLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showLoading = false;
  }

  Future scan(BuildContext context) async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": 'Cerrar',
          "flash_on": 'Flash',
          "flash_off": 'Apagar',
        },
      );

      var result = await BarcodeScanner.scan(options: options);

      if (result.rawContent != '') {
        print('Resultado del scan: ' + result.rawContent);
        codigoLeido(result.rawContent, context);
      } else
        print('No se escaneo nada ');
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _showLoading
          ? LogginCargando()
          : InkWell(
              onTap: () {
                scan(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: SizeConfig.safeBlockHorizontal * 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tocá la cámara para escanear tu DNI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                ],
              ),
            ),
    );
  }
}
