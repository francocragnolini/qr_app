import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

// Servicio Centralizado donde vamos a buscar la informacion

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  // para saber cual es la opcion seleccionada si estamos en Mapas o Direcciones
  // tambien podria hacerse desde el ui Provider
  String tipoSeleccionado = "http";

  //? 1)
  nuevoScan(String valor) async {
    // crea la instancia del modelo
    final nuevoScan = ScanModel(valor: valor);

    // inserta el nuevoScan (regresa el id del registro insertado)
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    // asignar el id de la base de datos al modelo
    nuevoScan.id = id;

    // validacion en base al tipo
    if (tipoSeleccionado == nuevoScan.tipo) {
      // inserta el nuevo scan al listado de scans
      scans.add(nuevoScan);

      notifyListeners();
    }
  }

  cargarScans() async {
    final res = await DBProvider.db.getAllScans();
    scans = [...res!];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final res = await DBProvider.db.getScansPorTipo(tipo);
    scans = [...res!];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    //? 2
    // await cargarScansPorTipo(tipoSeleccionado);
  }
}



//? 1) siempre se inserta el registro en base de datos, la condicion solo se aplica en 
//? base al ui del provider (Scans)

//? 2) elimina el registro por ID y ejecuta la funcion cargarScansPorTipo() para obtener el listado actualizado
//? no utiliza el notifyListeners en borrarScanPorId porque va a notificar dos veces ya que cargarScansPorTipo() tiene un notifyListeners()

//? 2) como utiliza el dismisable para borrar el widget del UI no es necesaria esta linea : await cargarScansPorTipo(tipoSeleccionado);