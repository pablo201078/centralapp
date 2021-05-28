import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final int idCliente;
  final List<String> busquedas;

  CustomSearchDelegate(
      {String hintText = "Buscar en Central App",
      @required this.idCliente,
      @required this.busquedas})
      : super(
          searchFieldLabel: hintText,
          searchFieldStyle:
              TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4.0),
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty)
            close(context, null);
          else
            query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    if (query.isEmpty) return Container();

    if (query.length < 3) {
      return Center(
        child: Text(
          'El texto de busqueda debe ser más largo',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red[300],
              fontSize: SizeConfig.safeBlockHorizontal * 5.0),
        ),
      );
    }
    Future.delayed(Duration.zero, () {
      close(context, query);
    });

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var lista = query.isEmpty
        ? busquedas ?? []
        : busquedas
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.search),
          title: RichText(
            text: TextSpan(
              text: lista[index].substring(0, query.length),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
              children: [
                TextSpan(
                  text: lista[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          trailing: Icon(Icons.call_made),
          onTap: () {
            query = lista[index];
            close(context, query);
          },
        );
      },
    );
  }
}
