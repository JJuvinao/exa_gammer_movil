import 'dart:io';
import 'package:flutter/material.dart';
import 'src/inicio.dart';
import 'src/login.dart';
import 'src/registro.dart';
import 'src/principal.dart';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = _MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exa Gammer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // La ruta que se cargará al iniciar la app
      routes: {
        '/': (context) =>
            const MyHomePage(), // La ruta base es tu página principal
        '/login': (context) => const LoginPage(),
        '/registro': (context) => const RegistroPage(),
        '/principal': (context) => const PrincipalPage(),
      },
    );
  }
}
