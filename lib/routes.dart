import 'package:flutter/material.dart';

// Importa todas las pantallas con la ruta correcta
import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/driver_profile/driver_profile_screen.dart';
import 'screens/booking/booking_screen.dart';

// Mapa de rutas
final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const HomeScreen(),
  '/driverProfile': (context) => const DriverProfileScreen(),
  '/booking': (context) => const BookingScreen(),
};
