import 'package:centralApp/data/repositories/compras.dart';
import 'package:centralApp/data/models/credito.dart';
import 'package:flutter/material.dart';
import 'package:centralApp/utils.dart';

class CompraDetalleDeuda extends StatefulWidget {
  final idCredito;

  CompraDetalleDeuda({Key key, this.idCredito});

  @override
  _CompraDetalleDeudaState createState() => _CompraDetalleDeudaState();
}

class _CompraDetalleDeudaState extends State<CompraDetalleDeuda> {
  Future<List<Deuda>> _futuro;
  var comprasRepo = ComprasRepository();
  @override
  void initState() {
    super.initState();
    _futuro = comprasRepo.getDeuda(widget.idCredito);
  }

  Widget _buildLista(List<Deuda> lista) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: SizeConfig.blockSizeVertical * 50.0,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                endIndent: 20,
                indent: 20,
                color: Colors.redAccent,
              ),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Cuota ${lista[index].nroCuota}',
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${lista[index].fecha}',
                  ),
                  trailing: Text(
                    formatCurrencyDec.format(lista[index].monto),
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.clear, size: 30, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Deuda>>(
      future: _futuro,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Container(
              height: 200, child: Center(child: Text('Error en la Conexión')));
        if (!snapshot.hasData) return _Cargando();
        if (snapshot.data.isEmpty) return _Cargando();
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return _buildLista(snapshot.data);
        }
        return _Cargando();
      },
    );
  }
}

class _Cargando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
