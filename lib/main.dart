import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/ui/screens/articulo_detalle/widgets/articulo_detalle_galeria.dart';
import 'package:centralApp/ui/screens/carrito/carrito.dart';
import 'package:centralApp/ui/screens/destacados_hogar/destacados_hogar.dart';
import 'package:centralApp/ui/screens/destacados_comercial/destacados_comercial.dart';
import 'package:centralApp/ui/screens/deuda_vencida/deuda_vencida.dart';
import 'package:centralApp/ui/screens/equipamiento_comercial/equipamiento_comercial.dart';
import 'package:centralApp/ui/screens/favoritos/favoritos.dart';
import 'package:centralApp/ui/screens/historial/historial.dart';
import 'package:centralApp/ui/screens/hogar/hogar.dart';
import 'package:centralApp/ui/screens/loggin/login.dart';
import 'package:centralApp/ui/screens/mis_compras/mis_compras.dart';
import 'package:centralApp/ui/screens/mis_compras_detalle/mis_compras_detalle.dart';
import 'package:centralApp/ui/screens/pedido_detalle/pedido_detalle.dart';
import 'package:centralApp/ui/screens/pedidos/pedidos.dart';
import 'package:centralApp/ui/screens/search_result/search_result.dart';
import 'package:centralApp/ui/screens/ticket/ticket.dart';
import 'package:centralApp/ui/screens/usados/usados.dart';
import 'package:centralApp/ui/screens/renovacion_efectivo/renovacion_efectivo.dart';
import 'package:centralApp/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'data/repositories//pedidos.dart';
import 'data/repositories/usuario.dart';
import 'data/repositories/compras.dart';
import 'utils.dart';
import 'one_signal.dart';
import 'logic/carrito.dart';
import 'logic/pedidos.dart';
import 'ui/screens/articulo_detalle/articulo_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'logic/usuario_bloc.dart';
import 'ui/screens/credencial/credencial.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ui/screens/home/home.dart';

void inicializarApp(UsuarioBloc loggedModel, CarritoModel carritoModel,
    PedidoBloc pedidosModel) async {
  print('inicializar app');
  var idCliente = await getIdCliente();
  var usuarioRepo = UsuarioRepository();
  var articuloRepo = ArticuloRepository();
  var comprasRepo = ComprasRepository();

  //inicializo oneSignal aunque no este logueado
  await inicializarOneSignal();

  if (idCliente != 0) {
    bool rta = await usuarioRepo.checkLogin(idCliente);
    if (rta) {
      print('sesion ok');
      String qr = await usuarioRepo.getQr(loggedModel, idCliente);
      if ((qr ?? '') != '') {
        loggedModel.favoritos = await articuloRepo.getFavoritos(idCliente);
        loggedModel.deudaVencida = await comprasRepo.getCreditosDeudaContador(idCliente);
        carritoModel.articulos = await articuloRepo.getCarrito(idCliente);
        pedidosModel.pedidos = await getPedidos(idCliente);
      }
    } else {
      loggedModel.logged = false;
    }
  }
  loggedModel.busquedas = await usuarioRepo.getBusquedas(idCliente);
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

  UsuarioBloc loggedModel = UsuarioBloc();
  CarritoModel carritoModel = CarritoModel();
  PedidoBloc pedidosModel = PedidoBloc();

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
  final UsuarioBloc loggedModel;
  final CarritoModel carritoModel;

  const MyApp({Key key, this.loggedModel, this.carritoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => ScopedModel<UsuarioBloc>(
        model: loggedModel,
        child: ScopedModel<CarritoModel>(
          model: carritoModel,
          child: OverlaySupport(
            child: GetMaterialApp(
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
                '/equipamiento_comercial': (context) => EquipamientoComercial(),
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
            ),
          ),
        ),
      ),
    );
  }
}
