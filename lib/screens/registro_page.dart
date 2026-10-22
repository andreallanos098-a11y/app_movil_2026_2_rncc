
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../routes/app_routes.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _dniController = TextEditingController();
  final _celularController = TextEditingController();

  String _saludo = '';

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _dniController.dispose();
    _celularController.dispose();
    super.dispose();
  }

  String? _validarCorreo(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'El correo electrónico es obligatorio';
    }

    final regex = RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,}$');

    if (!regex.hasMatch(valor)) {
      return 'Ingresa un correo válido';
    }

    return null;
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vilca Market - Registro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_saludo.isNotEmpty) ...[
                Text(
                  _saludo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombres y apellidos',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
                  ),
                ],
                onChanged: (valor) {
                  setState(() {
                    _saludo = valor.trim().isEmpty
                        ? ''
                        : 'Hola, ${valor.trim()}';
                  });
                },
                validator: (valor) {
                  if (valor == null || valor.trim().length < 3) {
                    return 'Ingresa al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                validator: _validarCorreo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dniController,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: const InputDecoration(
                  labelText: 'DNI',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (valor) {
                  if (valor == null || valor.length != 8) {
                    return 'El DNI debe tener 8 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _celularController,
                keyboardType: TextInputType.phone,
                maxLength: 9,
                decoration: const InputDecoration(
                  labelText: 'Celular',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (valor) {
                  if (valor == null ||
                      valor.length != 9 ||
                      !valor.startsWith('9')) {
                    return 'Debe tener 9 dígitos y empezar con 9';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _enviar,
                icon: const Icon(Icons.save),
                label: const Text('Registrar cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
