import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/bottom_navbar.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  final List<_TripItem> trips = const [
    _TripItem(
      passengerName: 'Daniela Jojoa',
      career: 'Psicología',
      city: 'Buga',
      timeRange: '6:30 PM-10:00 PM',
      price: 8000,
      status: TripStatus.confirmed,
      imagePath: 'assets/images/Daniela.png',
    ),
    _TripItem(
      passengerName: 'Pedro Lucumí',
      career: 'Derecho',
      city: 'Buenaventura',
      timeRange: '6:30 PM-10:00 PM',
      price: 10000,
      status: TripStatus.cancelled,
      imagePath: 'assets/images/Pedro.png',
    ),
    _TripItem(
      passengerName: 'Giamcito-kun',
      career: 'Medicina',
      city: 'Trujillo',
      timeRange: '6:30 PM-10:00 PM',
      price: 15000,
      status: TripStatus.completed,
      imagePath: 'assets/images/kun.png',
    ),
  ];

  int _currentIndex = 1;

  void _onNavTap(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        return;
      case 2:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    ),
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
                    'Mis viajes',
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
                child: ListView.separated(
                  itemCount: trips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return _TripCard(
                      trip: trip,
                      onCancel: trip.status == TripStatus.confirmed
                          ? () => Navigator.pushNamed(context, '/cancelTrip')
                          : null,
                      onRate: trip.status == TripStatus.completed
                          ? () => Navigator.pushNamed(context, '/driverRating')
                          : null,
                    );
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

enum TripStatus { confirmed, cancelled, completed }

class _TripItem {
  final String passengerName;
  final String career;
  final String city;
  final String timeRange;
  final int price;
  final TripStatus status;
  final String imagePath;

  const _TripItem({
    required this.passengerName,
    required this.career,
    required this.city,
    required this.timeRange,
    required this.price,
    required this.status,
    required this.imagePath,
  });
}

class _TripCard extends StatelessWidget {
  final _TripItem trip;
  final VoidCallback? onCancel;
  final VoidCallback? onRate;

  const _TripCard({
    required this.trip,
    this.onCancel,
    this.onRate,
  });

  Color get _statusColor {
    switch (trip.status) {
      case TripStatus.confirmed:
        return AppColors.success;
      case TripStatus.cancelled:
        return const Color(0xFFE35757);
      case TripStatus.completed:
        return AppColors.secondary;
    }
  }

  String get _statusLabel {
    switch (trip.status) {
      case TripStatus.confirmed:
        return 'Confirmado';
      case TripStatus.cancelled:
        return 'Cancelado';
      case TripStatus.completed:
        return 'Completado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _statusLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '\$${trip.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  trip.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.passengerName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trip.career,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 16, color: AppColors.secondary),
                        const SizedBox(width: 4),
                        Text(
                          trip.city,
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
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 18, color: AppColors.secondary),
                  const SizedBox(width: 6),
                  Text(
                    trip.timeRange,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (onRate != null)
                TextButton(
                  onPressed: onRate,
                  child: const Text(
                    'Calificar',
                    style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w700),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
