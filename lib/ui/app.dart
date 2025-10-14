import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    GetMaterialApp(
      title: 'EXA-GAMMER',
      debugShowCheckedModeBanner: false,
      home: HomePage(), 
    );
  }
}
