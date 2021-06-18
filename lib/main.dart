import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/routes.dart';
import 'package:centralApp/theme.dart';
import 'package:centralApp/ui/screens/articulo_detalle/articulo_detalle.dart';
import 'package:centralApp/ui/screens/home/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'data/repositories//pedidos.dart';
import 'data/repositories/usuario.dart';
import 'data/repositories/compras.dart';
import 'utils.dart';
import 'one_signal.dart';
import 'logic/carrito.dart';
import 'logic/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'logic/usuario_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app_links/app_links.dart';

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
        loggedModel.deudaVencida =
            await comprasRepo.getCreditosDeudaContador(idCliente);
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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  final UsuarioBloc loggedModel;
  final CarritoModel carritoModel;

  const MyApp({Key key, this.loggedModel, this.carritoModel}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  AppLinks _appLinks;

  @override
  void initState() {
    initDeepLinks();
    super.initState();
  }

  void initDeepLinks() async {
    _appLinks = AppLinks(
      onAppLink: (Uri uri, String stringUri) {
        print('onAppLink: $stringUri');
        openAppLink(uri);
      },
    );

    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null && appLink.hasFragment && appLink.fragment != '/') {
      print('getInitialAppLink: ${appLink.toString()}');
      openAppLink(appLink);
    }
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState?.pushNamed(uri.fragment);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => ScopedModel<UsuarioBloc>(
        model: widget.loggedModel,
        child: ScopedModel<CarritoModel>(
          model: widget.carritoModel,
          child: OverlaySupport(
            child: GetMaterialApp(
              title: 'Central App',
            /*  onGenerateRoute: (RouteSettings settings) {
                Widget routeWidget = Home();

                final routeName = settings.name;
                if (routeName != null) {
                  print('acaaaaaaaaaa: ' + routeName);
                  if (routeName.startsWith('/articulos/')) {
                    // Navigated to /book/:id
                    routeWidget = ArticuloDetalle(idArticulo: 54
                     *//* routeName.substring(
                        routeName.indexOf('/book/'),
                      ),*//*
                    );
                  } else if (routeName == '/book') {
                    // Navigated to /book without other parameters
                    routeWidget = ArticuloDetalle(idArticulo: 54,);
                  }
                }

                return MaterialPageRoute(
                  builder: (context) => routeWidget,
                  settings: settings,
                  fullscreenDialog: true,
                );
              },*/
              initialRoute: '/',
              routes: getRoutes(),
              debugShowCheckedModeBanner: false,
              theme: theme(),
            ),
          ),
        ),
      ),
    );
  }
}
