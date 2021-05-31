import 'package:centralApp/logic/logged_model.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/boton_buscar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/responsive.dart';
import 'package:centralApp/utils.dart';
import 'package:centralApp/notificaciones.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_body.dart';
import 'package:centralApp/ui/widgets/menu_lateral/menu_lateral.dart';
import 'package:centralApp/ui/widgets/boton_carrito.dart';

class Home extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Future<bool> _onWillPop() {
      if (_scaffoldKey.currentState.isDrawerOpen)
        _scaffoldKey.currentState.openEndDrawer();
      else
        return dialogoCerrarApp(context, _scaffoldKey) ?? false;
    }

    final LoggedModel loggedModel =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

    print('home build');

    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(
        context,
        title: 'Central  App',
        size: 20.sp,
        drawer: true,
        actions: [
          BotonBuscar(),
          BotonCarrito(),
        ],
      ),
      drawer: /*Responsive.isMobile(context) ?*/ MenuLateral() /* : null*/,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Responsive(
          mobile: HomeBody(
              idCliente:
                  loggedModel.isLogged ? loggedModel.getUser.idCliente : 0),
          tablet: HomeBody(
              idCliente:
                  loggedModel.isLogged ? loggedModel.getUser.idCliente : 0),
          desktop: Row(
            children: [
              Expanded(
                flex: 2,
                child: MenuLateral(),
              ),
              Expanded(
                flex: 8,
                child: HomeBody(
                    idCliente: loggedModel.isLogged
                        ? loggedModel.getUser.idCliente
                        : 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
