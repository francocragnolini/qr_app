import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    // getter
    // pasa el valor a la propiedad currentIndex
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (value) {
        // setter cambia el valor(index)
        uiProvider.selectedMenuOpt = value;
      },
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          //? mostrar coordenadas
          label: "Mapa",
        ),

        //? mostrar direcciones url
        BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration_outlined),
            label: "Direcciones"),
      ],
    );
  }
}
