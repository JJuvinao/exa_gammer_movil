import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagosPremiumView extends StatefulWidget {
  final String plan;
  final String precio;

  const PagosPremiumView({
    super.key,
    required this.plan,
    required this.precio,
  });

  @override
  State<PagosPremiumView> createState() => _PagosPremiumViewState();
}

class _PagosPremiumViewState extends State<PagosPremiumView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _buyerNameController = TextEditingController();
  final TextEditingController _buyerEmailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();

  final List<String> _bancos = [
    'Bancolombia',
    'Davivienda',
    'Banco de Bogotá',
    'BBVA',
    'Banco Agrario',
  ];
  String? _bancoSeleccionado;

  bool _isProcessing = false;

  @override
  void dispose() {
    _buyerNameController.dispose();
    _buyerEmailController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }

  void _onRealizarPagoPressed() {
    if (_buyerNameController.text.trim().isEmpty ||
        _buyerEmailController.text.trim().isEmpty ||
        _cardNumberController.text.trim().isEmpty ||
        (_bancoSeleccionado == null || _bancoSeleccionado!.isEmpty)) {
      Get.snackbar(
        'Campos incompletos',
        'Por favor completa todos los campos obligatorios.',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar pago'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Plan: ${widget.plan}'),
              Text('Precio: ${widget.precio}'),
              const SizedBox(height: 8),
              const Text('Comprador:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_buyerNameController.text),
              Text(_buyerEmailController.text),
              const SizedBox(height: 8),
              const Text('Banco:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_bancoSeleccionado ?? ''),
              const SizedBox(height: 8),
              const Text('Tarjeta:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_last4(_cardNumberController.text)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _procesarPagoSimulado();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  String _last4(String cardNumber) {
    final digits = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (digits.length >= 4) {
      return '**** **** **** ${digits.substring(digits.length - 4)}';
    }
    return cardNumber;
  }

  Future<void> _procesarPagoSimulado() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _isProcessing = false);

    await Future.delayed(const Duration(milliseconds: 300));
    Get.back(); // Cierra la vista actual

    Future.delayed(const Duration(milliseconds: 400), () {
      Get.snackbar(
        'Pago exitoso',
        'El plan "${widget.plan}" ha sido activado. Gracias por tu compra.',
        backgroundColor: Colors.green[600],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade400),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1), // fondo personalizado
      appBar: AppBar(
        title: const Text(
          'Pago - Premium',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.plan,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(widget.precio,
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _buyerNameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Nombre completo',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: cardStyle,
                    enabledBorder: cardStyle,
                    focusedBorder: cardStyle.copyWith(
                        borderSide: const BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 14),

                DropdownButtonFormField<String>(
                  value: _bancoSeleccionado,
                  decoration: InputDecoration(
                    labelText: 'Selecciona tu banco',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: cardStyle,
                    enabledBorder: cardStyle,
                    focusedBorder: cardStyle.copyWith(
                        borderSide: const BorderSide(color: Colors.black)),
                  ),
                  items: _bancos
                      .map((b) =>
                          DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (v) => setState(() => _bancoSeleccionado = v),
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Número de tarjeta',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: cardStyle,
                    enabledBorder: cardStyle,
                    focusedBorder: cardStyle.copyWith(
                        borderSide: const BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: _buyerEmailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: cardStyle,
                    enabledBorder: cardStyle,
                    focusedBorder: cardStyle.copyWith(
                        borderSide: const BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 28),

                _isProcessing
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _onRealizarPagoPressed,
                          child: const Text(
                            'Realizar pago',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}