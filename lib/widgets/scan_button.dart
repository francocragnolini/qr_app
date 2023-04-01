import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

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

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        //? simulando una url
        // const barcodeScanResult = "https://fernando-herrera.com";
        // scanListProvider.nuevoScan(barcodeScanResult);
        const barcodeScanGeo = "geo:15.654345,-45.678456";
        // scanListProvider.nuevoScan(barcodeScanGeo);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanGeo);
        //?1)
        launchURL(context, nuevoScan);
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}

//?1) launchURL(context, nuevoScan) : navega a otra pantalla cuando se presiona el boton