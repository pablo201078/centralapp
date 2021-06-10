import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:centralApp/data/repositories/usuario.dart';
import 'package:centralApp/logic/usuario_bloc.dart';
import 'package:centralApp/data/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:centralApp/notificaciones.dart';
import 'package:centralApp/constantes.dart';

class MenuLateralHeaderUsuario extends StatefulWidget {
  Usuario usuario;

  MenuLateralHeaderUsuario({Key key, @required this.usuario});

  @override
  _MenuLateralHeaderUsuarioState createState() =>
      _MenuLateralHeaderUsuarioState();
}

class _MenuLateralHeaderUsuarioState extends State<MenuLateralHeaderUsuario> {
  File _image;
  final picker = ImagePicker();
  ImageProvider imagenPerfil;

  @override
  Widget build(BuildContext context) {
    final UsuarioBloc loggedModel =
        ScopedModel.of<UsuarioBloc>(context, rebuildOnChange: true);

    if (loggedModel.getUser.imagen != '') {
      imagenPerfil = Image.network(
        loggedModel.getUser.imagen,
        key: ValueKey(
          Random().nextInt(100),
        ),
      ).image;
    } else
      imagenPerfil = Image.asset('assets/imagenes/usuario.png').image;

    // TODO: implement build
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ]),
      ),
      accountName: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Text(
          widget.usuario.nombre,
          maxLines: 1,
        ),
      ),
      accountEmail: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          widget.usuario.localidad,
          maxLines: 1,
        ),
      ),
      arrowColor: Colors.white,
      currentAccountPicture: GestureDetector(
        onTap: () async {
          int rta = await dialogoOrigenImagen(context);

          if (rta == 0) return;

          final pickedFile = await picker.getImage(
              source: rta == 2 ? ImageSource.gallery : ImageSource.camera,
              maxHeight: 400,
              maxWidth: 400);
          if (pickedFile != null) {
            setState(() {
              _image = File(pickedFile.path);
            });

            String base64Image = base64Encode(
              _image.readAsBytesSync(),
            );

            String fileName = pickedFile.path.split('/').last;
            var usuarioRepo = UsuarioRepository();
            if (await usuarioRepo.postImagen(
                fileName, base64Image, widget.usuario.idCliente)) {
              print('imagen subida ok');
              imageCache.clear();
              loggedModel.actualizarUrlImagen(
                  '${url_base}getProfileImg.php?idCliente=${widget.usuario.idCliente}');
            }
          }
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage:
              _image != null ? Image.file(_image).image : imagenPerfil,
          //child: Text('AH'),
        ),
      ),
    );
  }
}
