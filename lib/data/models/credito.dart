class Credito {
  final int idCredito;
  final int idTipo;
  final int idArticulo;
  final String fechaAlta;
  final String fechaPrimerCuota;
  final String fechaFinalizacion;
  final String descripcion;
  final String codArticulo;

  final int cantidad;
  final int cc;
  final int nroCuota;
  final String plan;
  final String
      hoy; //el dia habia de la cuota q paga . si es sabado o domingo es el viernes anterior. es para poner el cartelito de : Hoy 9 de noviembre pagas la cuota X de 200.
  final double cuota;
  final double deuda;
  final int adelantos;
  final int cuotasRestantes;
  final bool actual;

  Credito({
    this.idCredito,
    this.idTipo,
    this.idArticulo,
    this.actual,
    this.fechaAlta,
    this.fechaPrimerCuota,
    this.fechaFinalizacion,
    this.descripcion,
    this.codArticulo,
    this.cantidad,
    this.cc,
    this.nroCuota,
    this.plan,
    this.hoy,
    this.cuota,
    this.deuda,
    this.cuotasRestantes,
    this.adelantos,
  });

  factory Credito.fromJson(Map<String, dynamic> jsonData) {
    return Credito(
      idCredito: int.parse(jsonData['idCredito']),
      idTipo: int.parse(jsonData['idTipo']),
      idArticulo: int.parse(jsonData['idArticulo']),
      fechaAlta: jsonData['fechaAlta'] as String,
      fechaPrimerCuota: jsonData['fechaPrimerCuota'] as String,
      fechaFinalizacion: jsonData['fechaFinalizacion'] as String,
      hoy: jsonData['hoy'] as String,
      descripcion: jsonData['descripcion'] as String,
      codArticulo: jsonData['codArticulo'] as String,
      cantidad: int.parse(jsonData['cantidad']),
      cc: int.parse(jsonData['cc']),
      cuota: double.parse(jsonData['cuota']),
      nroCuota: int.parse(jsonData['nroCuota']),
      cuotasRestantes: int.parse(jsonData['cuotasRestantes']),
      plan: jsonData['plan'],
      deuda: double.parse(jsonData['deuda']),
      actual: jsonData['actual'] == '1',
      adelantos: int.parse(jsonData['adelantado']),
    );
  }
}

class Pago {
  final String fecha;
  final int anio;
  final double monto;

  Pago({
    this.fecha,
    this.monto,
    this.anio,
  });

  factory Pago.fromJson(Map<String, dynamic> jsonData) {
    return Pago(
      anio: int.parse(jsonData['anio']),
      fecha: jsonData['fecha'] as String,
      monto: double.parse(jsonData['monto']),
    );
  }
}

class Deuda {
  final String fecha;
  final int anio;
  final int nroCuota;
  final double monto;

  Deuda({
    this.fecha,
    this.monto,
    this.nroCuota,
    this.anio,
  });

  factory Deuda.fromJson(Map<String, dynamic> jsonData) {
    return Deuda(
      anio: int.parse(jsonData['anio']),
      nroCuota: int.parse(jsonData['nroCuota']),
      fecha: jsonData['fecha'] as String,
      monto: double.parse(jsonData['monto']),
    );
  }
}
