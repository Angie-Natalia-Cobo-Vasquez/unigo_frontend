import 'package:flutter/material.dart';

// Importa todas las pantallas con la ruta correcta
import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/driver_profile/driver_profile_screen.dart';
import 'screens/booking/booking_screen.dart';
import 'screens/payment/payment_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/recovery/password_recovery_screen.dart';
import 'screens/filters/filter_trips_screen.dart';
import 'screens/favorites/favorites_screen.dart';
import 'screens/trips/my_trips_screen.dart';
import 'screens/trips/cancel_trip_screen.dart';
import 'screens/ratings/driver_rating_screen.dart';

// Mapa de rutas
final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const HomeScreen(),
  '/driverProfile': (context) => const DriverProfileScreen(),
  '/booking': (context) => const BookingScreen(),
  '/payment': (context) => const PaymentScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/editProfile': (context) => const EditProfileScreen(),
  '/passwordRecovery': (context) => const PasswordRecoveryScreen(),
  '/filterTrips': (context) => const FilterTripsScreen(),
  '/favorites': (context) => const FavoritesScreen(),
  '/myTrips': (context) => const MyTripsScreen(),
  '/cancelTrip': (context) => const CancelTripScreen(),
  '/driverRating': (context) => const DriverRatingScreen(),
};
