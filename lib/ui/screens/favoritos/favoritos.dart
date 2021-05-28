import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/logic/scoped/logged_model.dart';
import 'package:centralApp/ui/screens/favoritos/widgets/favoritos_card_detalles.dart';
import 'package:centralApp/ui/screens/home/widgets/sin_conexion.dart';
import 'package:centralApp/utils.dart';
import 'package:centralApp/ui/widgets/app_bar.dart';
import 'package:centralApp/ui/widgets/articulo_banner_oferta.dart';
import 'package:centralApp/ui/widgets/articulo_card/widgets/articulo_card_imagen.dart';
import 'package:centralApp/ui/widgets/boton_buscar.dart';
import 'package:centralApp/ui/widgets/boton_carrito.dart';
import 'package:centralApp/ui/widgets/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/notificaciones.dart';

final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

class Favoritos extends StatelessWidget {
  int idCliente;
  Favoritos({Key key, this.idCliente});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    this.idCliente = arguments['idCliente'];

    return Scaffold(
      appBar: buildAppBar(context,
          title: 'Favoritos', actions: [BotonBuscar(), BotonCarrito()]),
      body: _Body(
        idCliente: this.idCliente,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int idCliente;
  _Body({@required this.idCliente});
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  Future<List<Articulo>> _futuro;
  var articuloRepository = ArticuloRepository();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futuro = articuloRepository.getFavoritos(widget.idCliente);
  }

  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);

    return FutureBuilder<List<Articulo>>(
      future: _futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError) return SinConexion();
        if (!snapshot.hasData) return LoadingList(itemsCount: 10);

        model.favoritos = snapshot.data;
        return _buildResultado(context);
      },
    );
  }

  Widget _buildResultado(BuildContext context) {
    List<Articulo> favoritos =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false).favoritos;

    if (favoritos.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 60,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Todavia no agregaste nada a Favoritos",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: SizeConfig.safeBlockHorizontal * 5.0),
            ),
          ),
        ],
      );
    }
    return _Lista();
  }
}

class _Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Articulo> favoritos =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: false).favoritos;

    return AnimatedList(
      key: listKey,
      initialItemCount: favoritos.length,
      itemBuilder: (context, index, animation) {
        return slideIt(
            context, favoritos[index], index, animation); // Refer step 3
      },
    );
  }
}

Widget slideIt(BuildContext context, Articulo articulo, int index, animation) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(animation),
    child: _Card(articulo: articulo, index: index),
  );
}

class _Card extends StatelessWidget {
  final Articulo articulo;
  final int index;

  _Card({Key key, @required this.articulo, @required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articulo_detalle',
            arguments: {'articulo': articulo});
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dx <= -1000) {
          _eliminar(context, index, articulo);
        }
      },
      child: Stack(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 13,
            child: _ContenidoCard(
              articulo: articulo,
              index: index,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).accentColor,
                    style: BorderStyle.solid),
              ),
            ),
          ),
          Visibility(
            visible: articulo.oferta,
            child: Positioned(
              left: 4,
              top: -3,
              child: ArticuloBannerOferta(
                angulo: 6.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContenidoCard extends StatelessWidget {
  final Articulo articulo;
  final int index;
  _ContenidoCard({Key key, @required this.articulo, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: ArticuloCardImagen(articulo: articulo)),
          Expanded(flex: 2, child: FavoritosCardDetalles(articulo: articulo)),
          /*boton eliminar*/
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.clear,
              size: 35,
            ),
            onPressed: () {
              _eliminar(context, index, articulo);
            },
          )
        ],
      ),
    );
  }
}

void _eliminar(BuildContext context, int index, Articulo articulo) async {
  LoggedModel model =
      ScopedModel.of<LoggedModel>(context, rebuildOnChange: false);
  var articuloRepository = ArticuloRepository();
  bool rta = await articuloRepository.postFavorito(
      articulo, model.getUser.idCliente, false);

  if (rta) {
    HapticFeedback.lightImpact();
    listKey.currentState.removeItem(
      index,
      (_, animation) => slideIt(context, articulo, index, animation),
      duration: const Duration(milliseconds: 400),
    );
    model.eliminarFavorito(articulo);
  } else
    showSnackBar(context, 'Oops, algo salio mal.', Colors.red);
}
