import 'package:flutter/material.dart';
import '../models/product_args.dart';
import '../routes/app_routes.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vilca Market - Inicio')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Productos de la región'),
          const SizedBox(height: 8),
          ProductCard(
            name: 'Quinua orgánica 1 kg',
            price: 12.50,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.detail,
              arguments: ProductArgs(
                title: 'Quinua orgánica 1 kg',
                price: 12.50,
                description: 'Quinua nativa seleccionada de alto valor nutricional.',
                image: 'quinua.png',
              ),
            ),
          ),
          ProductCard(
            name: 'Chuño blanco 500 g',
            price: 9.00,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.detail,
              arguments: ProductArgs(
                title: 'Chuño blanco 500 g',
                price: 9.00,
                description: 'Técnica ancestral de deshidratación de papa autóctona.',
                image: 'chuno.png',
              ),
            ),
          ),
          ProductCard(
            name: 'Queso paria 250 g',
            price: 11.00,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.detail,
              arguments: ProductArgs(
                title: 'Queso paria 250 g',
                price: 11.00,
                description: 'Queso madurado artesanal con leche pura de vaca.',
                image: 'queso.png',
              ),
            ),
          ),
          ProductCard(
            name: 'Miel de abeja 350 ml',
            price: 18.00,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.detail,
              arguments: ProductArgs(
                title: 'Miel de abeja 350 ml',
                price: 18.00,
                description: 'Miel 100% natural de flores silvestres altoandinas.',
                image: 'miel.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}