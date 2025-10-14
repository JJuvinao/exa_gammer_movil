import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const Color fondoExa = Color(0xFFC8C1C1); 

    return Scaffold(
      backgroundColor: fondoExa,
      appBar: AppBar(
        backgroundColor: fondoExa,
        elevation: 0,
        toolbarHeight: 0, 
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.01), // Espacio superior
              Text(
                'Exa-Gammer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.13,
                  color: Colors.black,
                  fontFamily: 'TitanOne',
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ), // Espacio entre título y logo
              Flexible(
                child: Image.asset(
                  'assets/imagen/logo_exa.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.09),



              Center(
                child: SizedBox(
                  width: screenWidth * 0.7, 
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(()=> Vistalogin());                     
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D59A1),
                      elevation: 0,
                      foregroundColor: Color(0XFFFAF4F4),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02, 
                        horizontal: screenWidth * 0.05,
                      ),

                      textStyle: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.3),
                      ),
                    ),
                    child: const Text('Comenzar')
                    ,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
