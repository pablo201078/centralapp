class TicketItem {
  final double monto;
  final double deuda;
  final double adelanto;
  final String fecha;
  final String hora;
  final String dia;
  final int puntos;
  final int cc;
  final bool hoy;
  final String hoyDia;
  final double montoCuota;
  final int idCredito;
  final int nroCuota;
  final String detalle;

  TicketItem(
      {this.monto,
      this.detalle,
      this.cc,
      this.nroCuota,
      this.montoCuota,
      this.idCredito,
      this.deuda,
      this.hoy = false,
      this.hoyDia, //la fecha de hoy, la usado para poner el carte de q el ticket no es de Hoy DD de MES
      this.adelanto,
      this.fecha,
      this.hora,
      this.dia,
      this.puntos});

  factory TicketItem.fromJson(Map<String, dynamic> jsonData) {
    return TicketItem(
      fecha: jsonData['fecha'] as String,
      hora: jsonData['hora'] as String,
      dia: jsonData['dia'] as String,
      monto: double.parse(jsonData['importe']),
      deuda: double.parse(jsonData['deuda']),
      puntos: int.parse(jsonData['puntos']),
      cc: int.parse(jsonData['cc']),
      hoy: jsonData['esDeHoy'] == '1',
      hoyDia: jsonData['hoyDia'],
      idCredito: int.parse(jsonData['idCredito']),
      montoCuota: double.parse(jsonData['montoCuota']),
      nroCuota: int.parse(jsonData['nroCuota']),
      adelanto: double.parse(jsonData['adelantado']),
      detalle: jsonData['descripcion'] as String,
    );
  }
}
