import 'package:centralApp/data/models/articulo.dart';
import 'package:centralApp/data/repositories/articulos.dart';
import 'package:centralApp/logic/scoped/logged_model.dart';

void clickFavorito(Articulo articulo, LoggedModel loggedModel) async {
  var articuloRepository = ArticuloRepository();

  if (loggedModel.isLogged && loggedModel.getUser.idTipo == 1) {
    bool rta = await articuloRepository.postFavorito(
      articulo,
      loggedModel.getUser.idCliente,
      !articulo.favorito,
    );

    if (rta) {
      if (articulo.favorito)
        loggedModel.eliminarFavorito(articulo);
      else
        loggedModel.agregarFavorito(articulo);
      articulo.setFav = !articulo.favorito;
    }
  }
  /*else
      showSnackBar(context, 'Oops, algo salio mal.', Colors.red);
  } else
    showSnackBar(context, txtIniciarSesion, Colors.redAccent);*/
}
