import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/src/navbar.dart';
import 'package:exa_gammer_movil/src/objetos/usuario.dart';
import 'package:exa_gammer_movil/src/servicios/userservices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late Userfrom userfrom;
  String _name = '';
  String _password = '';
  bool _isLoading = false;

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        Userdto user = Userdto(username: _name, password: _password);
        var result = await UserService().login(user);

        final token = result['token'];
        userfrom = result['user'];

        if (userfrom != null) {
          Navigator.pushNamed(context, '/');
        }
        print(userfrom);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login exitoso! Bienvenido, ${user.username}'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Login',
        botones: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registro');
            },
            child: const Text(
              'Registrarse',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu nombre';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: handleSubmit,
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
