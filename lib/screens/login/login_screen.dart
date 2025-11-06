import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('UniGo',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Image.asset('assets/icons/image.png', height: 80),
            const SizedBox(height: 20),
            const Text('INICIAR SESIÓN',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            CustomTextField(hint: 'Correo', controller: emailController),
            CustomTextField(
                hint: 'Contraseña', obscureText: true, controller: passwordController),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Entrar',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/register'),
              child: const Text('Crear Cuenta',
                  style: TextStyle(decoration: TextDecoration.underline)),
            ),
            const SizedBox(height: 6),
            const Text('Recuperar contraseña'),
          ],
        ),
      ),
    );
  }
}
