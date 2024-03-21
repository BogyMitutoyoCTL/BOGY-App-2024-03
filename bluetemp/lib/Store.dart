import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Storage extends StatefulWidget {
  Storage({super.key});
  final LocalStorage storage = LocalStorage('local storage_app');

  @override
  State<Storage> createState() => _StorageState();
  void addItemsToLocalStorage() {
    storage.setItem('name', 'Abolfazl');
    storage.setItem('family', 'Roshanzamir');

    final info = json.encode({'name': 'Darush', 'family': 'Roshanzami'});
    storage.setItem('info', info);
  }

  var info_name;
  void getitemFromLocalStorage() {
    final name = storage.getItem('name'); // Abolfazl
    final family = storage.getItem('family'); // Roshanzamir
    print(name);

    Map<String, dynamic> info = json.decode(storage.getItem('info'));
    final info_name = info['name'];
    final info_family = info['family'];
  }
}

class _StorageState extends State<Storage> {
  @override
  Widget build(BuildContext context) {
    widget.addItemsToLocalStorage();
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
