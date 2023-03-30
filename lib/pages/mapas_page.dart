import 'dart:developer';

import 'package:flutter/material.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) => ListTile(
        leading: Icon(
          Icons.map,
          color: Theme.of(context).primaryColor,
        ),
        title: Text("https://assdafggsgss"),
        subtitle: Text("ID: 1"),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.grey,
        ),
        onTap: () {
          log("abrir algo");
        },
      ),
    );
  }
}
