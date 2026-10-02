import 'package:flutter/material.dart';

void main() {
  runApp(const MiPerfilApp());
}

class MiPerfilApp extends StatelessWidget {
  const MiPerfilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Perfil Académico Interactivo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
      ),
      home: const PerfilScreen(),
    );
  }
}

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final String nombreCompleto = 'Rosaura Nélida Ccari Ccari';
  final int numeroPersonal = 48;
  final double promedioPonderado = 16.5;
  final bool estaMatriculado = true;

  late int logrosAcademicos = numeroPersonal;

  @override
  Widget build(BuildContext context) {
    String mensajeParImpar = (numeroPersonal % 2 == 0)
        ? 'Tu número personal es par'
        : 'Tu número personal es impar';

    String mensajeRango = (numeroPersonal > 50)
        ? 'Número personal alto'
        : 'Número personal bajo';

    List<String> multiplosList = [];
    for (int i = 1; i <= 5; i++) {
      int resultado = numeroPersonal * i;
      multiplosList.add('$numeroPersonal × $i = $resultado');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          nombreCompleto,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tarjeta 1: Datos Personales
                _buildCard(
                  title: '1. Datos Personales (Sesión 02)',
                  icon: Icons.person,
                  color: Colors.indigo.shade50,
                  borderColor: Colors.indigo,
                  children: [
                    _buildInfoRow('Nombre:', nombreCompleto),
                    _buildInfoRow('Número Personal (NP):', '$numeroPersonal'),
                    _buildInfoRow('Promedio Ponderado:', '$promedioPonderado'),
                    _buildInfoRow('Matriculado:', estaMatriculado ? 'Sí' : 'No'),
                  ],
                ),
                const SizedBox(height: 16),

                // Tarjeta 2: Clasificación if-else
                _buildCard(
                  title: '2. Lógica con if-else (Sesión 02)',
                  icon: Icons.alt_route,
                  color: Colors.teal.shade50,
                  borderColor: Colors.teal,
                  children: [
                    _buildInfoRow('Paridad:', mensajeParImpar),
                    _buildInfoRow('Rango:', mensajeRango),
                  ],
                ),
                const SizedBox(height: 16),

                // Tarjeta 3: Múltiplos con for
                _buildCard(
                  title: '3. Primeros 5 Múltiplos (Bucle for)',
                  icon: Icons.list_alt,
                  color: Colors.amber.shade50,
                  borderColor: Colors.amber.shade700,
                  children: multiplosList
                      .map((m) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text('• $m', style: const TextStyle(fontSize: 16)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // Tarjeta 4: Interactividad StatefulWidget
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.military_tech, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              '4. Interactividad (StatefulWidget)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Text(
                          'Logros académicos: $logrosAcademicos',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              logrosAcademicos++;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Sumar logro',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color borderColor,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor.withOpacity(0.5), width: 1.5),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: borderColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: borderColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          Text(value, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        ],
      ),
    );
  }
}