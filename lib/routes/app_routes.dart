import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/quantity_screen.dart';
import '../models/product_args.dart';

class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
  static const String quantity = '/quantity';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
        
      case detail:
        if (settings.arguments is ProductArgs) {
          final args = settings.arguments as ProductArgs;
          return MaterialPageRoute(builder: (_) => DetailScreen(product: args));
        }
        return _errorRoute('Se requieren argumentos ProductArgs válidos.');

      case quantity:
        final int currentQty = settings.arguments is int ? settings.arguments as int : 1;
        return MaterialPageRoute(builder: (_) => QuantityScreen(initialValue: currentQty));

      default:
        return _errorRoute('Ruta no encontrada: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error de Navegación')),
        body: Center(child: Text(message, style: const TextStyle(color: Colors.red, fontSize: 16))),
      ),
    );
  }
}