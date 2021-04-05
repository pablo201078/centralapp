import 'package:centralApp/models/articulo.dart';
import 'package:flutter/material.dart';
import '../../../utils.dart';

class ArticuloPlanes extends StatefulWidget {
  final Articulo articulo;

  ArticuloPlanes({Key key, this.articulo});

  @override
  _ArticuloPlanesState createState() => _ArticuloPlanesState();
}

class _ArticuloPlanesState extends State<ArticuloPlanes> {
  Plan planActual;
  var lista = List<Plan>();

  @override
  void initState() {
    super.initState();

    if (widget.articulo.en250 != 0) {
      lista.add(
        Plan(
            cc: 250,
            oferta: widget.articulo.en250bon,
            monto: widget.articulo.en250),
      );
    }

    lista.add(
      Plan(
          cc: 200,
          oferta: widget.articulo.en200bon,
          monto: widget.articulo.en200),
    );

    lista.add(
      Plan(
          cc: 100,
          oferta: widget.articulo.en100bon,
          monto: widget.articulo.en100),
    );

    planActual =
        lista.firstWhere((element) => element.cc == widget.articulo.cc);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        height: SizeConfig.safeBlockVertical * 6.5,
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.withOpacity(0.15),
          border: Border.all(color: Colors.blueAccent),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Plan>(
            value: planActual,
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: SizeConfig.blockSizeHorizontal * 4.0),
            onChanged: (Plan planNuevo) {
              setState(() {
                planActual = planNuevo;
                widget.articulo.cc = planNuevo.cc;
              });
            },
            items: lista.map<DropdownMenuItem<Plan>>((Plan value) {
              return DropdownMenuItem<Plan>(
                value: value,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${value.cc} cuotas de ${widget.articulo.oferta ? formatearNumero(value.oferta) : formatearNumero(value.monto)}'),
                        Visibility(
                          visible: widget.articulo.oferta,
                          child: Text(
                            'Antes ${formatearNumero(value.monto)}',
                            style: TextStyle(
                                // fontWeight: FontWeight.w800,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                                color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
