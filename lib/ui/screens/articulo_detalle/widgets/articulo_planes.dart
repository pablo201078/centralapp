import 'package:centralApp/data/models/articulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:centralApp/utils.dart';

class ArticuloPlanes extends StatefulWidget {
  final Articulo articulo;
  ArticuloPlanes({Key key, this.articulo});
  @override
  _ArticuloPlanesState createState() => _ArticuloPlanesState();
}

class _ArticuloPlanesState extends State<ArticuloPlanes> {
  Plan planActual;
  var lista = <Plan>[];

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
        height: 0.07.sh,
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
                fontSize: 15.sp),
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
                                fontSize: 12.sp,
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
