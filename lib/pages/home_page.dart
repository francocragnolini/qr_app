// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_reader/pages/direcciones_page.dart';
// import 'package:qr_reader/pages/mapas_page.dart';
// import 'package:qr_reader/providers/db_provider.dart';
// import 'package:qr_reader/providers/scan_list_provider.dart';
// import 'package:qr_reader/providers/ui_provider.dart';

// import 'package:qr_reader/widgets/custom_navigatorbar.dart';
// import 'package:qr_reader/widgets/scan_button.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     DBProvider.db.database;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Historial"),
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.delete_forever),
//           )
//         ],
//       ),
//       body: _HomePageBody(),
//       bottomNavigationBar: CustomNavigationBar(),
//       floatingActionButton: ScanButton(),

//       //? para determinar la ubicacion del floatingActionButton
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

// //! aca se colocan las paginas direcciones_page.dart y mapas_page.dart
// class _HomePageBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //? obtener ui provider to manage the bottomNavigationBar index
//     final uiProvider = Provider.of<UiProvider>(context);

//     //? cambiar para mostrar la pagina respectiva en el body en base al index
//     final int currentIndex = uiProvider.selectedMenuOpt;

//     //! Para Testear el servicio a la base de datos
//     // TODO: Temporal leer la base de datos
// final temporalScan = ScanModel(valor: "geo:47.345678,14.234567");

//     //? int porque el future retorna un int
// DBProvider.db.nuevoScan(temporalScan);

//     //? buscar scan por id y retornar el valor
//     //? http://google.com
//     // DBProvider.db.getScanById(16).then((scan) => log('${scan?.valor}'));

//     //? get all scans
//     //? lista de http://google.com
//     // DBProvider.db.getAllScans().then((scan) => log('$scan'));
//     //!

//     final scanListProvider =
//         Provider.of<ScanListProvider>(context, listen: false);

//     switch (currentIndex) {
//       case 0:
//         scanListProvider.cargarScansPorTipo("geo");
//         return const MapasPage();
//       case 1:
//         scanListProvider.cargarScansPorTipo("http");
//         return const DireccionesPage();

//       default:
//         return const MapasPage();
//     }
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),

      //? para determinar la ubicacion del floatingActionButton
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//! aca se colocan las paginas direcciones_page.dart y mapas_page.dart
class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //? obtener ui provider to manage the bottomNavigationBar index
    final uiProvider = Provider.of<UiProvider>(context);

    //? cambiar para mostrar la pagina respectiva en el body en base al index
    final int currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo("geo");
        return const DireccionesPage();
      case 1:
        scanListProvider.cargarScansPorTipo("http");
        return const MapasPage();

      default:
        return const MapasPage();
    }
  }
}
