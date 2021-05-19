import 'package:centralApp/screens/articulo_detalle/widgets/articulo_detalle_galeria.dart';
import 'package:centralApp/screens/carrito/carrito.dart';
import 'package:centralApp/screens/destacados_hogar/destacados_hogar.dart';
import 'package:centralApp/screens/destacados_comercial/destacados_comercial.dart';
import 'package:centralApp/screens/deuda_vencida/deuda_vencida.dart';
import 'package:centralApp/screens/equipamiento_comercial/equipamiento_comercial.dart';
import 'package:centralApp/screens/favoritos/favoritos.dart';
import 'package:centralApp/screens/historial/historial.dart';
import 'package:centralApp/screens/hogar/hogar.dart';
import 'package:centralApp/screens/loggin/login.dart';
import 'package:centralApp/screens/mis_compras/mis_compras.dart';
import 'package:centralApp/screens/mis_compras_detalle/mis_compras_detalle.dart';
import 'package:centralApp/screens/pedido_detalle/pedido_detalle.dart';
import 'package:centralApp/screens/pedidos/pedidos.dart';
import 'package:centralApp/screens/search_result/search_result.dart';
import 'package:centralApp/screens/ticket/ticket.dart';
import 'package:centralApp/screens/usados/usados.dart';
import 'package:centralApp/screens/renovacion_efectivo/renovacion_efectivo.dart';
import 'package:centralApp/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'api/articulos.dart';
import 'api/pedidos.dart';
import 'api/usuario.dart';
import 'api/compras.dart';
import 'utils.dart';
import 'one_signal.dart';
import 'models/scoped/carrito.dart';
import 'models/scoped/pedidos.dart';
import 'screens/articulo_detalle/articulo_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'models/scoped/logged_model.dart';
import 'screens/credencial/credencial.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/home/home.dart';

void inicializarApp(LoggedModel loggedModel, CarritoModel carritoModel,
    PedidosModel pedidosModel) async {
  print('inicializar app');
  var idCliente = await getIdCliente();
  //inicializo oneSignal aunque no este logueado
  await inicializarOneSignal();

  if (idCliente != 0) {
    bool rta = await checkLogin(idCliente);
    if (rta) {
      print('sesion ok');
      String qr = await getQr(loggedModel, idCliente);
      if ((qr ?? '') != '') {
        loggedModel.favoritos = await getFavoritos(idCliente);
        loggedModel.deudaVencida = await getCreditosDeudaContador(idCliente);
        carritoModel.articulos = await getCarrito(idCliente);
        pedidosModel.pedidos = await getPedidos(idCliente);
      }
    } else {
      loggedModel.logged = false;
    }
  }
  loggedModel.busquedas = await getBusquedas(idCliente);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  LoggedModel loggedModel = LoggedModel();
  CarritoModel carritoModel = CarritoModel();
  PedidosModel pedidosModel = PedidosModel();

  inicializarApp(loggedModel, carritoModel, pedidosModel);

  runApp(
    MyApp(
      loggedModel: loggedModel,
      carritoModel: carritoModel,
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final LoggedModel loggedModel;
  final CarritoModel carritoModel;

  const MyApp({Key key, this.loggedModel, this.carritoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoggedModel>(
      model: loggedModel,
      child: ScopedModel<CarritoModel>(
        model: carritoModel,
        child: OverlaySupport(
          child: Sizer(
            builder: (context, orientation, deviceType) {
              return GetMaterialApp(
                title: 'Central App',
                initialRoute: '/',
                routes: {
                  '/': (context) => Home(),
                  '/loggin': (context) => Loggin(),
                  '/credencial': (context) => Credencial(),
                  '/carrito': (context) => Carrito(),
                  '/search_result': (context) => SearchResult(),
                  '/favoritos': (context) => Favoritos(),
                  '/historial': (context) => Historial(),
                  '/pedidos': (context) => Pedidos(),
                  '/pedido_detalle': (context) => PedidoDetalle(),
                  '/hogar': (context) => Hogar(),
                  '/equipamiento_comercial': (context) =>
                      EquipamientoComercial(),
                  '/usados': (context) => Usados(),
                  '/deuda_vencida': (context) => DeudaVencida(),
                  '/mis_compras': (context) => MisCompras(),
                  '/mis_compras_detalle': (context) => MisComprasDetalle(),
                  '/destacadosHogar': (context) => DestacadosHogar(),
                  '/destacadosComercial': (context) => DestacadosComercial(),
                  '/articulo_detalle': (context) => ArticuloDetalle(),
                  '/renovacion_efectivo': (context) => RenovacionEfectivo(),
                  '/articulo_detalle_galeria': (context) =>
                      ArticuloDetalleGaleria(),
                  '/ticket': (context) => Ticket(),
                },
                debugShowCheckedModeBanner: false,
                theme: theme(),
              );
            },
          ),
        ),
      ),
    );
  }
}
