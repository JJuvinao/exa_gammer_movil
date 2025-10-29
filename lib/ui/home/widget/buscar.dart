import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class BuscarClase extends StatelessWidget {
  final ClaseController pc = Get.find();

  BuscarClase({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'Buscar clase',
        prefixIcon: Icon(Icons.search),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      onChanged: (value) {
        pc.setSearchQuery(value);
      },
    );
  }
}
