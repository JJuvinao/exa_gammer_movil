import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/user_model.dart';

class PagosPremiumView extends StatefulWidget {
  final String plan;
  final String precio;

  const PagosPremiumView({super.key, required this.plan, required this.precio});

  @override
  State<PagosPremiumView> createState() => _PagosPremiumViewState();
}

class _PagosPremiumViewState extends State<PagosPremiumView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _buyerNameController = TextEditingController();
  final TextEditingController _buyerEmailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expMonthController = TextEditingController();
  final TextEditingController _expYearController = TextEditingController();

  final List<String> _bancos = [
    'Bancolombia',
    'Davivienda',
    'Banco de Bogotá',
    'BBVA',
    'Banco Agrario',
  ];

  final List<String> _tiposTarjeta = [
    'Débito',
    'Crédito',
  ];

  String? _bancoSeleccionado;
  String? _tipoTarjetaSeleccionado;
  bool _isProcessing = false;

  @override
  void dispose() {
    _buyerNameController.dispose();
    _buyerEmailController.dispose();
    _cardNumberController.dispose();
    _cvvController.dispose();
    _expMonthController.dispose();
    _expYearController.dispose();
    super.dispose();
  }

  Future<void> _onRealizarPagoPressed() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1f1f2e),
        title: const Text('¿Confirmar pago?', style: TextStyle(color: Colors.white)),
        content: Text(
          '¿Deseas activar el plan "${widget.plan}" por ${widget.precio}?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar', style: TextStyle(color: Colors.cyan)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar', style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      _procesarPagoSimulado();
    }
  }

  Future<void> _procesarPagoSimulado() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _isProcessing = false);

    final userController = Get.find<UserController>();
    final user = userController.getuser;

    final actualizado = User(
      id: user.id,
      username: user.username,
      rol: user.rol,
      email: user.email,
      img: user.img,
      premium: true,
    );

    final exito = await userController.actualizarPremium(user.id, true);

    if (exito) {
      Get.back();
      Future.delayed(const Duration(milliseconds: 400), () {
        Get.snackbar(
          '¡Listo!',
          'Tu cuenta ahora es premium.',
          backgroundColor: Colors.green[600],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
        );
      });
    } else {
      Get.snackbar(
        'Error',
        'No se pudo activar el plan premium.',
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade600),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a14),
      appBar: AppBar(
        title: const Text('Confirmar pago'),
        backgroundColor: const Color(0xFF16213e),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1f1f2e),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(widget.plan,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(widget.precio,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white70)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildField('Nombre completo', _buyerNameController, cardStyle),
                    const SizedBox(height: 14),
                    _buildDropdown('Banco', _bancos, _bancoSeleccionado, (v) {
                      setState(() => _bancoSeleccionado = v);
                    }, cardStyle),
                    const SizedBox(height: 14),
                    _buildDropdown('Tipo de tarjeta', _tiposTarjeta, _tipoTarjetaSeleccionado, (v) {
                      setState(() => _tipoTarjetaSeleccionado = v);
                    }, cardStyle),
                    const SizedBox(height: 14),
                    _buildField('Número de tarjeta', _cardNumberController, cardStyle,
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField('Mes (MM)', _expMonthController, cardStyle,
                              keyboardType: TextInputType.number),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField('Año (AA)', _expYearController, cardStyle,
                              keyboardType: TextInputType.number),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildField('CVV', _cvvController, cardStyle,
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 14),
                    _buildField('Correo electrónico', _buyerEmailController, cardStyle,
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 28),
                    _isProcessing
                        ? const Center(child: CircularProgressIndicator(color: Colors.white))
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.lock, size: 20),
                              label: const Text('Realizar pago',
                                  style: TextStyle(fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[600],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: _onRealizarPagoPressed,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, OutlineInputBorder style,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black,
        border: style,
        enabledBorder: style,
        focusedBorder: style.copyWith(borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selected, Function(String?) onChanged,
      OutlineInputBorder style) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black,
        border: style,
        enabledBorder: style,
        focusedBorder: style.copyWith(borderSide: const BorderSide(color: Colors.white)),
      ),
      dropdownColor: Colors.black,
      items: items
          .map((item) => DropdownMenuItem(
              value: item, child: Text(item, style: const TextStyle(color: Colors.white))))
          .toList(),
      onChanged: onChanged,
    );
  }
}