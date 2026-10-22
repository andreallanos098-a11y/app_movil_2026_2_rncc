import 'package:flutter/material.dart';
import '../widgets/quantity_selector.dart';

class QuantityScreen extends StatefulWidget {
  final int initialValue;

  const QuantityScreen({super.key, required this.initialValue});

  @override
  State<QuantityScreen> createState() => _QuantityScreenState();
}

class _QuantityScreenState extends State<QuantityScreen> {
  late int _tempQuantity;

  @override
  void initState() {
    super.initState();
    _tempQuantity = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Cantidad')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Indique la cantidad deseada (1 - 20)', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            QuantitySelector(
              value: _tempQuantity,
              min: 1,
              max: 20,
              onChanged: (newValue) {
                setState(() {
                  _tempQuantity = newValue;
                });
              },
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, null),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context, _tempQuantity),
                    child: const Text('Confirmar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
