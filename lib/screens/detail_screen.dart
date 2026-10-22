import 'package:flutter/material.dart';
import '../models/product_args.dart';
import '../routes/app_routes.dart';

class DetailScreen extends StatefulWidget {
  final ProductArgs product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final double unitPrice = widget.product.price;
    final double total = unitPrice * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text(
              'Precio unitario: S/ ${unitPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              'Cantidad seleccionada: $_quantity',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              'Total a pagar: S/ ${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  // Navegación asíncrona hacia la pantalla de cantidad enviando el valor actual
                  final dynamic result = await Navigator.pushNamed(
                    context,
                    AppRoutes.quantity,
                    arguments: _quantity,
                  );

                  // RT4: Comprobación de mounted después del await
                  if (!mounted) return;

                  // Si el usuario confirma un valor (no es nulo), actualizamos el estado
                  if (result != null && result is int) {
                    setState(() {
                      _quantity = result;
                    });
                  }
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Elegir cantidad'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
