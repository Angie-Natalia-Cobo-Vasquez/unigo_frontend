import 'package:flutter/material.dart';
import 'package:unigo_frontend/models/user_model.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthDateController = TextEditingController();
  DateTime? _selectedBirthDate;

  @override
  void dispose() {
    _nameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        /*boxShadow: [
                          BoxShadow(
                            color: Color(0x11000000),
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],*/
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  /*const SizedBox(width: 16),
                  const Text(
                    'Recuperación de contraseña',
                    style: TextStyle(
                      //color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),*/
                  const Text(
                    'DriveU',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset('assets/icons/image.png', height: 90),
                  const SizedBox(height: 20),
                  const Text(
                    'Regístrate',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 35),

                  _buildInput('Nombre', _nameController),
                  _buildInput('Apellido', _lastnameController),
                  _buildInput(
                    'Correo',
                    _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildInput(
                    'Contraseña',
                    _passwordController,
                    obscureText: true,
                  ),
                  _buildDateInput(context),
                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 44, 199, 152),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final user = UserModel(
                            nombres: _nameController.text.trim(),
                            apellidos: _lastnameController.text.trim(),
                            correo: _emailController.text.trim(),
                            telefono: '',
                            password: _passwordController.text,
                            birthDate: _selectedBirthDate != null
                                ? _formatDateForBackend(_selectedBirthDate!)
                                : '',
                          );

                          final success = await AuthService.instance.register(
                            user,
                          );

                          if (!mounted) return;

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cuenta creada correctamente'),
                              ),
                            );
                            final navigator = Navigator.of(context);
                            Future.delayed(const Duration(seconds: 1), () {
                              navigator.pushReplacementNamed('/login');
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AuthService.instance.error ??
                                      'No se pudo crear la cuenta',
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Crear Cuenta',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    String hint,
    TextEditingController controller, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return TextFormField(
      controller: _birthDateController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Fecha de Nacimiento',
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        suffixIcon: const Icon(
          Icons.calendar_today_outlined,
          color: Color.fromARGB(255, 44, 199, 152),
        ),
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedBirthDate = pickedDate;
            _birthDateController.text = _formatDateForDisplay(pickedDate);
          });
        }
      },
    );
  }

  String _formatDateForDisplay(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return "$day/$month/$year";
  }

  String _formatDateForBackend(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }
}
