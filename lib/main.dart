import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MODELO (proporcionado por la guía)
class Producto {
  final int id;
  final String nombre;
  final double precio;
  const Producto(this.id, this.nombre, this.precio);
}

const catalogo = [
  Producto(1, 'Arroz 1 kg', 4.80),
  Producto(2, 'Aceite 1 L', 9.50),
  Producto(3, 'Azúcar 1 kg', 4.20),
  Producto(4, 'Fideos 500 g', 3.40),
  Producto(5, 'Leche evaporada', 4.10),
];

// TODO 1: ESTADO GLOBAL (CarritoModel)
class CarritoModel extends ChangeNotifier {
  final Map<int, int> _cantidades = {};

  int cantidadDe(Producto p) => _cantidades[p.id] ?? 0;

  int get totalUnidades => _cantidades.values.fold(0, (sum, qty) => sum + qty);

  double get total {
    double sum = 0.0;
    _cantidades.forEach((id, qty) {
      final producto = catalogo.firstWhere((p) => p.id == id);
      sum += producto.precio * qty;
    });
    return sum;
  }

  List<MapEntry<Producto, int>> get productosEnCarrito {
    List<MapEntry<Producto, int>> lista = [];
    _cantidades.forEach((id, qty) {
      if (qty > 0) {
        final producto = catalogo.firstWhere((p) => p.id == id);
        lista.add(MapEntry(producto, qty));
      }
    });
    return lista;
  }

  void agregar(Producto p) {
    _cantidades[p.id] = (_cantidades[p.id] ?? 0) + 1;
    notifyListeners(); // Notifica a los Consumer para actualizar la UI
  }

  void quitar(Producto p) {
    if (_cantidades.containsKey(p.id)) {
      if (_cantidades[p.id]! > 1) {
        _cantidades[p.id] = _cantidades[p.id]! - 1;
      } else {
        _cantidades.remove(p.id);
      }
      notifyListeners();
    }
  }

  void vaciar() {
    _cantidades.clear();
    notifyListeners();
  }
}

void main() {
  // TODO 2: Ubicar ChangeNotifierProvider POR ENCIMA de MaterialApp[cite: 8, 9]
  runApp(
    ChangeNotifierProvider(
      create: (_) => CarritoModel(),
      child: const VilcaMarketApp(),
    ),
  );
}

class VilcaMarketApp extends StatelessWidget {
  const VilcaMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vilca Market',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1F4E79),
      ),
      home: const PantallaCatalogo(),
    );
  }
}

// TODO 3: PANTALLA CATÁLOGO
class PantallaCatalogo extends StatelessWidget {
  const PantallaCatalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vilca Market'),
        actions: [
          Consumer<CarritoModel>(
            builder: (context, carrito, child) {
              return IconButton(
                icon: const Icon(Icons.shopping_cart),
                tooltip: 'Ver carrito (${carrito.totalUnidades} productos)',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PantallaCarrito()),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        itemCount: catalogo.length,
        itemBuilder: (context, index) {
          final producto = catalogo[index];
          return ListTile(
            title: Text(
              producto.nombre,
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            subtitle: Consumer<CarritoModel>(
              builder: (context, carrito, child) {
                final enCarrito = carrito.cantidadDe(producto);
                return Text('S/ ${producto.precio.toStringAsFixed(2)} | En carrito: $enCarrito');
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              tooltip: 'Agregar ${producto.nombre} al carrito',
              onPressed: () {
                // En callbacks se usa listen: false[cite: 8, 10]
                Provider.of<CarritoModel>(context, listen: false).agregar(producto);
              },
            ),
          );
        },
      ),
    );
  }
}

// TODO 4: PANTALLA CARRITO
class PantallaCarrito extends StatelessWidget {
  const PantallaCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi carrito'),
        actions: [
          Consumer<CarritoModel>(
            builder: (context, carrito, child) {
              if (carrito.productosEnCarrito.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                tooltip: 'Vaciar carrito',
                onPressed: () => carrito.vaciar(),
              );
            },
          ),
        ],
      ),
      body: Consumer<CarritoModel>(
        builder: (context, carrito, child) {
          final items = carrito.productosEnCarrito;
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Tu carrito está vacío',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final entry = items[index];
                    final producto = entry.key;
                    final cantidad = entry.value;
                    return ListTile(
                      title: Text(producto.nombre),
                      subtitle: Text('Precio: S/ ${producto.precio.toStringAsFixed(2)} x $cantidad = S/ ${(producto.precio * cantidad).toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Cant: $cantidad', style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            tooltip: 'Quitar una unidad',
                            onPressed: () {
                              Provider.of<CarritoModel>(context, listen: false).quitar(producto);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total a pagar:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'S/ ${carrito.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F4E79)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}