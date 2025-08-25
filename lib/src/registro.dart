import 'package:exa_gammer_movil/src/objetos/usuario.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exa_gammer_movil/src/navbar.dart';
import 'package:exa_gammer_movil/src/servicios/userservices.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedRole;
  XFile? _imageFile;
  String? _imagebase64;
  String? _mensage;

  bool _usernameExists = false;
  bool _isCheckingUsername = false;

  @override
  void dispose() {
    /*_usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();*/
    super.dispose();
  }

  // Función para verificar el nombre de usuario
  void _checkUsername() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      setState(() {
        _usernameExists = false;
      });
      return;
    }

    setState(() {
      _isCheckingUsername = true;
    });

    final exists = await _userService.checkUsernameExists(username);

    setState(() {
      _usernameExists = exists.exists;
      _isCheckingUsername = false;
      _mensage = exists.message;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _checkUsername();
      if (_usernameExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El nombre de usuario ya existe')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _mensage ?? "Registro exitoso $_usernameExists.toString()",
            ),
          ),
        );
      }
      /*ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Procesando datos...')));
    }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: 'Registro'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextFormField(
                controller: _usernameController,
                labelText: 'Nombre de usuario',
                hintText: '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre de usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: _passwordController,
                labelText: 'Contraseña',
                hintText: '',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _buildDropdownButtonFormField(),
              const SizedBox(height: 16.0),
              _buildTextFormField(
                controller: _emailController,
                labelText: 'Correo electrónico',
                hintText: '',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu correo electrónico';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, ingresa un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _buildProfileImagePicker(),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDropdownButtonFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rol',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _selectedRole,
          hint: const Text('Seleccionar su rol'),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          items: <String>['Estudiante', 'Administrador', 'Profesor'].map((
            String value,
          ) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Por favor, selecciona un rol';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildProfileImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Imagen de perfil',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[50],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Color(0xFFE0E0E0))),
                  ),
                  child: TextButton(
                    onPressed: () {
                      UserService userService = UserService();
                      userService.pickImage().then((image) {
                        userService.imageToBase64(image).then((base64) {
                          setState(() {
                            _imageFile = image;
                            _imagebase64 = base64;
                          });
                          print('Imagen en Base64: $base64');
                        });
                      });
                      // Lógica para seleccionar el archivo
                      print('Seleccionar archivo presionado');
                    },
                    child: const Text('Seleccionar archivo'),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _imageFile == null
                      ? const Text('No se ha seleccionado ninguna imagen')
                      : Text(
                          'Archivo: ${_imageFile!.name}',
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
