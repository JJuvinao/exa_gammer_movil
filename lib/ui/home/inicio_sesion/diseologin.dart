import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/add_user.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/login.dart';

class Vistalogin extends StatefulWidget {
  @override
  _VistaloginState createState() => _VistaloginState();
}

class _VistaloginState extends State<Vistalogin> {
  int selectedTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8F8A8A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 120),
              Row(
                children: [
                  Image.asset('assets/imagen/logo_exa.png', height: 75),
                  SizedBox(width: 12),
                  
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'EXA-GAMMER',
                        style: TextStyle(
                          fontSize:36, 
                          fontWeight: FontWeight.bold,
                          fontFamily: "TitanOne",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                ),

                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(child: _buildTab('INICIAR SESIÓN', 0)),
                            Expanded(child: _buildTab('Registrarse', 1)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      selectedTabIndex == 1 ? AgregarUsuario() : LoginForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTabIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              width: 3,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
