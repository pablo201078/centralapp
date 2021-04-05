import 'dart:convert';

class Articulo {
  final int idArticulo;
  final String codArticulo;
  final String urlImagen;
  final String urlImagenBase;
  final String descripcion;
  final String division;
  final String subdivision;
  final String especificaciones;
  final double en100;
  final double en200;
  final double en250;
  final double en100bon;
  final double en200bon;
  final double en250bon;
  int cc;
  int cantidad;
  final bool oferta;
  final bool usado;
  final int diasHistorial;
  bool favorito;
  final bool destacado;
  final bool equipamientoComercial;
  final int imagenes; // cantidad de imagenes
  final String link; //el link al mismo articulo en la web de amacar
  final List<Map<String, String>> caracteristicas;
  final List<Atributo> atributos;
  Atributo atributo;

  Articulo(
      {this.idArticulo,
      this.codArticulo,
      this.urlImagen,
      this.urlImagenBase,
      this.descripcion,
      this.division,
      this.subdivision,
      this.diasHistorial,
      this.especificaciones,
      this.en100,
      this.en200,
      this.en250,
      this.en100bon,
      this.en200bon,
      this.en250bon,
      this.cc, //sirve solo para cuando esta el carrito
      this.cantidad, //sirve solo para cuando esta el carrito
      this.atributo, //para el carrito, el atrobuto actual
      this.oferta,
      this.usado,
      this.equipamientoComercial,
      this.destacado,
      this.favorito,
      this.imagenes,
      this.caracteristicas,
      this.link,
      this.atributos});

  set setFav(bool value) {
    this.favorito = value;
  }

  set plan(int value) {
    this.cc = value;
  }

  int get plan => this.cc;
  int get getCantidad => this.cantidad;
  bool get tieneAtributo => this.atributos.length > 1;

  double get planActual {
    /*el plan que se selecciono para agregar al carrito, solo tiene sentido para los articulos en el carrito*/
    var cuota;
    switch (this.cc) {
      case 100:
        {
          cuota = this.oferta ? this.en100bon : this.en100;
        }
        break;

      case 200:
        {
          cuota = this.oferta ? this.en200bon : this.en200;
        }
        break;

      case 250:
        {
          cuota = this.oferta ? this.en250bon : this.en250;
        }
        break;
    }

    return cuota;
  }

  factory Articulo.fromJson(Map<String, dynamic> jsonData) {
    List<Map<String, String>> listacaracteristicas =
        List<Map<String, String>>();
    List<Atributo> listaAtributos = List<Atributo>();
    Atributo atributo;
    //las caracteristicas son un json
    for (var o in json.decode(jsonData['caracteristicas'])) {
      listacaracteristicas.add({o['titulo']: o['detalle']});
    }

    //atributos

    for (var o in json.decode(jsonData['atributos'])) {
      atributo = Atributo(
          idAtributo: int.parse(o['idAtributo']), atributo: o['atributo']);
      listaAtributos.add(atributo);
    }
    atributo = Atributo(idAtributo: 0, atributo: 'Elegi Uno');
    listaAtributos.insert(0, atributo);

    //tengo q buscar el atributo actual de este articulo ( solo para cuando esta en el carrito, de otra manera el atributo es 0 )
    atributo = listaAtributos
        .where((element) =>
            element.idAtributo == int.parse(jsonData['idAtributo']))
        .elementAt(0);

    return Articulo(
      idArticulo: int.parse(jsonData['idArticulo']),
      codArticulo: jsonData['codArticulo'] as String,
      urlImagen: jsonData['urlImagen'] as String,
      urlImagenBase: jsonData['urlImagenBase'] as String,
      descripcion: jsonData['descripcion'] as String,
      division: jsonData['division'] as String,
      subdivision: jsonData['subdivision'] as String,
      especificaciones: jsonData['especificaciones'] as String,
      en100: double.parse(jsonData['en100']),
      en200: double.parse(jsonData['en200']),
      en250: double.parse(jsonData['en250']),
      en100bon: double.parse(jsonData['en100bon']),
      en200bon: double.parse(jsonData['en200bon']),
      en250bon: double.parse(jsonData['en250bon']),
      oferta: (jsonData['oferta'] == '1'),
      usado: (jsonData['usado'] == '1'),
      destacado: (jsonData['destacado'] == '1'),
      favorito: (jsonData['favorito'] == '1'),
      equipamientoComercial: (jsonData['equipamientoComercial'] == '1'),
      cc: int.parse(jsonData['cc']),
      diasHistorial: int.parse(jsonData['diasHistorial']),
      cantidad: int.parse(jsonData['cantidad']),
      imagenes: int.parse(jsonData['imagenes']),
      caracteristicas: listacaracteristicas,
      atributos: listaAtributos,
      atributo: atributo,
      link: jsonData['link'] as String,
    );
  }
}

class Plan {
  final int cc;
  final double monto;
  final double oferta;

  Plan({this.cc, this.monto, this.oferta});
}

class Atributo {
  final int idAtributo;
  final String atributo;

  Atributo({this.idAtributo, this.atributo});
}
