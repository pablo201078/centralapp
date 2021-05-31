import 'package:centralApp/logic/logged_model.dart';
import 'package:centralApp/ui/screens/search/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/constantes.dart';

class BotonBuscar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoggedModel model =
        ScopedModel.of<LoggedModel>(context, rebuildOnChange: true);

    return IconButton(
      icon: const Icon(Icons.search, size: sizeActions ),
      onPressed: () async {
        var txt = await showSearch(
          context: context,
          delegate: CustomSearchDelegate(
              idCliente: model.isLogged ? model.getUser.idCliente : 0,
              busquedas: model.busquedas),
        );
        print('txt: ' + txt);
        if (txt.length > 2) {
          model.busquedas.insert(0, txt);
          Navigator.pushNamed(
            context,
            '/search_result',
            arguments: {'query': txt},
          );
        }
      },
    );
  }
}
