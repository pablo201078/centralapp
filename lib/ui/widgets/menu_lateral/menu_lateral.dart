import 'package:centralApp/logic/logged_model.dart';
import 'package:centralApp/logic/pedidos.dart';
import 'package:centralApp/ui/widgets/menu_lateral/widgets/menu_lateral_header_usuario.dart';
import 'package:centralApp/ui/screens/ticket/ticket.dart';
import 'package:centralApp/ui/widgets/contador.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/notificaciones.dart';
import 'package:centralApp/transiciones.dart';
import 'widgets/cerrar_session.dart';
import 'widgets/custom_list_tile.dart';
import 'widgets/menu_lateral_header.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                model.isLogged
                    ? MenuLateralHeaderUsuario(usuario: model.getUser)
                    : MenuLateralHeader(),
                CustomListTile(
                  title: 'Tarjeta Socio',
                  iconColor: model.isLogged ? Colors.black : Colors.grey,
                  icon: Icons.credit_card,
                  onTap: () {
                    if (model.isLogged) {
                      Navigator.of(context).pushNamed('/credencial');
                    } else
                      dialogoDebeIniciarSesion(context);
                  },
                ),
                CustomListTile(
                  title: 'Ticket de Pago',
                  iconColor: model.isLogged ? Colors.black : Colors.grey,
                  icon: Icons.account_balance_wallet,
                  onTap: () {
                    if (model.isLogged)
                      Navigator.push(
                        context,
                        ScaleRoute(
                          page: Ticket(),
                        ),
                      );
                    else
                      dialogoDebeIniciarSesion(context);
                  },
                ),
                CustomListTile(
                  title: 'Solicitar Efectivo',
                  iconColor: model.isLogged ? Colors.black : Colors.grey,
                  icon: Icons.monetization_on_outlined,
                  onTap: () {
                    if (model.isLogged) {
                      PedidoBloc pedidobloc = PedidoBloc();
                      if (model.getUser.idTipo == 1)
                        pedidobloc.comprobarVencimiento2(context, model.getUser.idCliente);
                      else
                        showWarning(context, () {},
                            'Tu usuario no esta Autorizado para realizar esta operación');
                    } else
                      dialogoDebeIniciarSesion(context);
                  },
                ),
                ScopedModel<PedidoBloc>(
                  model: PedidoBloc(),
                  child: _ItemPedidosActuales(),
                ),
                CustomListTile(
                  title: 'Mis Compras',
                  iconColor: model.isLogged && model.getUser.idTipo == 1
                      ? Colors.black
                      : Colors.grey,
                  icon: Icons.person,
                  onTap: () {
                    if (model.isLogged) {
                      if (model.getUser.idTipo == 1)
                        Navigator.pushNamed(context, '/mis_compras',
                            arguments: {'idCliente': model.getUser.idCliente});
                      else
                        showWarning(context, () {},
                            'Tu usuario no esta Autorizado para ver las Compras');
                    } else
                      dialogoDebeIniciarSesion(context);
                  },
                ),
                CustomListTile(
                  title: 'Deuda Vencida',
                  iconColor: model.isLogged && model.getUser.idTipo == 1
                      ? Colors.black
                      : Colors.grey,
                  icon: Icons.warning_amber_outlined,
                  trailing: Visibility(
                    visible: (model.isLogged && model.deudaVencida != 0),
                    child: Contador(
                      colorFondo: Colors.redAccent.withOpacity(0.3),
                      colorBorde: Colors.red,
                      colorTxt: Colors.redAccent,
                      txt: model.deudaVencida.toString(),
                    ),
                  ),
                  onTap: () {
                    if (model.isLogged) {
                      if (model.getUser.idTipo == 1)
                        Navigator.pushNamed(context, '/deuda_vencida',
                            arguments: {'idCliente': model.getUser.idCliente});
                      else
                        showWarning(context, () {},
                            'Tu usuario no esta Autorizado para ver la Deuda');
                    } else
                      dialogoDebeIniciarSesion(context);
                  },
                ),
              ],
            ),
          ),
          (model.isLogged && model.getUser.cierraSesion ??
                  false) //si esta logueado y puede cerrar sesion. Solo algun clientes pueden cerrar sesion( comparten celular para abrir dos cuentas )
              ? CerrarSesion(model: model)
              : Container()
        ],
      ),
    );
  }
}

class _ItemPedidosActuales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);
    final PedidoBloc pedidosModel =
        ScopedModel.of<PedidoBloc>(context, rebuildOnChange: true);

    return CustomListTile(
      title: 'Pedidos Actuales',
      iconColor: (model.isLogged && model.getUser.idTipo == 1)
          ? Colors.black
          : Colors.grey,
      icon: Icons.add_shopping_cart,
      trailing: Visibility(
        visible: pedidosModel.pedidosCantidad != 0,
        child: Contador(
          txt: pedidosModel.pedidosCantidad.toString(),
        ),
      ),
      onTap: () {
        if (model.isLogged) {
          if (model.getUser.idTipo == 1)
            Navigator.pushNamed(context, '/pedidos',
                arguments: {'idCliente': model.getUser.idCliente});
          else
            showWarning(context, () {},
                'Tu usuario no esta Autorizado para ver Pedidos');
        } else
          dialogoDebeIniciarSesion(context);
      },
    );
  }
}
