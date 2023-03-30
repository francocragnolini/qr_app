import 'dart:developer';

import 'package:flutter/material.dart';

//? no funciona el paquete - curso una vez mas completamente desactualizado
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

//? decidi probar con este paquete alternativo
// import 'package:barcode_scan2/barcode_scan2.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        log("scanning");
        //? no funciona el scanner intentar con otro dispositivo
        //? posibilidad la camara esta borrosa
        // final result = await BarcodeScanner.scan(
        //     options: const ScanOptions(strings: {
        //   'cancel': 'Cancelar',
        //   'flash_on': 'Flash_on',
        //   'flash_off': 'Flash_off',
        // }));

        // log(result.rawContent);

        //? simulando una url
        final result = "https://fernando-herrera.com";
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
