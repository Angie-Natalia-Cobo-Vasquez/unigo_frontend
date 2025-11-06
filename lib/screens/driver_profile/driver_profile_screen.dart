import 'package:flutter/material.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil del Conductor')),
      body: const Center(
        child: Text('Pantalla Perfil del Conductor'),
      ),
    );
  }
}
