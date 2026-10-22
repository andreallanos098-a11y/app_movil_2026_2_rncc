import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CatalogoDefectuoso()));

class CatalogoDefectuoso extends StatelessWidget {
  const CatalogoDefectuoso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vilca Market')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    const Text(
                      'Arroz 1 kg',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'S/ 4.80',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.add),
                      iconSize: 24,
                      tooltip: 'Agregar al carrito',
                      onPressed: () {},
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
}
