import 'package:flutter/material.dart';

import '../../models/driver.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bottom_navbar.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final favoriteDrivers = const [
    Driver(
      name: 'Adrián Saavedra',
      profession: 'Ingeniería Industrial',
      vehicle: 'Moto',
      rating: 4.5,
      reviews: 12,
      passengers: 32,
      bio:
          'Soy Adrián Saavedra, estudiante de 5 semestre de Ingeniería Industrial en la UCEVA. Vivo en Buga y estaría encantado de llevarte. Leer más...',
      imageUrl: 'assets/images/adrian.png',
      ridePrice: 8000,
      city: 'Buga',
    ),
    Driver(
      name: 'Daniela Hernández',
      profession: 'Psicóloga',
      vehicle: 'Carro',
      rating: 4.9,
      reviews: 18,
      passengers: 48,
      bio:
          'Conozco las rutas más rápidas y cómodas para llevarte a clase. Seguridad y puntualidad garantizadas.',
      imageUrl: 'assets/images/Hernandez.png',
      ridePrice: 10000,
      city: 'Andalucía',
    ),
  ];

  int _currentIndex = 2;

  void _onNavTap(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/myTrips');
        break;
      case 2:
        return;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x11000000),
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Mis favoritos',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteDrivers.length,
                  itemBuilder: (context, index) {
                    final driver = favoriteDrivers[index];
                    return _FavoriteCard(driver: driver);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: UniGoBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Driver driver;

  const _FavoriteCard({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 16,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: AssetImage(driver.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          driver.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Icon(Icons.favorite, color: AppColors.secondary),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    driver.profession,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.warning, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        driver.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        driver.city,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
