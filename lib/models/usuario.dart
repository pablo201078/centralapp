class Usuario {
  final int idCliente;
  final String hash;
  String qrCode;
  String qrFecha;
  final String nombre;
  final String localidad;
  final String dni;
  final String nroSocio;
  final String comercio;
  final String rubro;
  String imagen;
  bool imagenLocal;
  bool cierraSesion;
  int enCarrito;
  int idTipo; //1 = usuario normal, 2 = solo credencial

  set qr(value) {
    this.qrCode = value;
  }

  set setQrFecha(value) {
    this.qrFecha = value;
  }

  set hash(value) {
    this.hash = value;
  }

  Usuario(
      {this.idCliente,
      this.hash,
      this.qrCode,
      this.qrFecha,
      this.cierraSesion,
      this.nombre,
      this.localidad,
      this.dni,
      this.nroSocio,
      this.comercio,
      this.rubro,
      this.idTipo = 1,
      this.imagen,
      this.imagenLocal = false,
      this.enCarrito});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idCliente: json['idCliente'],
      hash: json['hash'],
      qrCode: json['qrCode'],
      qrFecha: json['qrFecha'],
      nombre: json['nombre'],
      localidad: json['localidad'],
      dni: json['dni'],
      idTipo: json['idTipo'],
      nroSocio: json['nroSocio'],
      comercio: json['comercio'],
      rubro: json['rubro'],
      imagen: json['imagen'],
      enCarrito: json['enCarrito'],
      cierraSesion: ( json['cierraSesion'] == '1' || json['cierraSesion'] == true ) ,
    );
  }

  Map<dynamic, dynamic> toJson() => {
        'idCliente': idCliente,
        'hash': hash,
        'qrCode': qrCode,
        'qrFecha': qrFecha,
        'nombre': nombre,
        'idTipo': idTipo,
        'localidad': localidad,
        'dni': dni,
        'nroSocio': nroSocio,
        'comercio': comercio,
        'rubro': rubro,
        'imagen': imagen,
        'enCarrito': enCarrito,
        'cierraSesion': cierraSesion,
      };
}

class Vencimiento {
  final int ok;
  final int idTipo;
  final String monto;

  Vencimiento({this.ok = 0, this.monto = '', this.idTipo});

  factory Vencimiento.fromJson(Map<String, dynamic> jsonData) {
    return Vencimiento(
      ok: jsonData['ok'],
      idTipo: jsonData['idTipo'],
      monto: jsonData['monto'] as String,
    );
  }
}
