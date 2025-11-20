import 'package:flutter/material.dart';

import '../../models/trip.dart';
import '../../repositories/trip_repository.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bottom_navbar.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  final TripRepository _tripRepository = TripRepository();
  TripStatus? _statusFilter;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _tripRepository.getTrips();
  }

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

  List<Trip> _filterTrips(List<Trip> trips) {
    if (_statusFilter == null) return trips;
    return trips.where((trip) => trip.status == _statusFilter).toList();
  }

  Future<void> _handleCancelTrip(Trip trip) async {
    final result = await Navigator.pushNamed(
      context,
      '/cancelTrip',
      arguments: trip,
    );

    if (!mounted) return;
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Viaje cancelado correctamente.')),
      );
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
              _TripStatusFilters(
                selected: _statusFilter,
                onSelected: (status) => setState(() => _statusFilter = status),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<List<Trip>>(
                  stream: _tripRepository.watchTrips(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('No se pudieron cargar los viajes.'),
                      );
                    }

                    final trips = _filterTrips(snapshot.data ?? []);
                    if (trips.isEmpty) {
                      return const Center(
                        child: Text(
                          'No tienes viajes en esta categoría todavía.',
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: trips.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final trip = trips[index];
                        return _TripCard(
                          trip: trip,
                          onCancel: trip.status == TripStatus.confirmed
                              ? () => _handleCancelTrip(trip)
                              : null,
                          onRate: trip.status == TripStatus.completed
                              ? () => Navigator.pushNamed(
                                  context,
                                  '/driverRating',
                                )
                              : null,
                        );
                      },
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

class _TripStatusFilters extends StatelessWidget {
  const _TripStatusFilters({required this.selected, required this.onSelected});

  final TripStatus? selected;
  final ValueChanged<TripStatus?> onSelected;

  @override
  Widget build(BuildContext context) {
    const options = <TripStatus?>[
      null,
      TripStatus.confirmed,
      TripStatus.completed,
      TripStatus.cancelled,
    ];

    String labelFor(TripStatus? status) {
      switch (status) {
        case null:
          return 'Todos';
        case TripStatus.confirmed:
          return 'Reservados';
        case TripStatus.completed:
          return 'Completados';
        case TripStatus.cancelled:
          return 'Cancelados';
      }
    }

    return Wrap(
      spacing: 12,
      children: options.map((status) {
        final isSelected = selected == status;
        return ChoiceChip(
          label: Text(labelFor(status)),
          selected: isSelected,
          onSelected: (_) => onSelected(isSelected ? null : status),
          backgroundColor: Colors.white,
          selectedColor: AppColors.secondary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }
}

class _TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onCancel;
  final VoidCallback? onRate;

  const _TripCard({required this.trip, this.onCancel, this.onRate});

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
                  trip.imageUrl,
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
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.secondary,
                        ),
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
                  const Icon(
                    Icons.access_time,
                    size: 18,
                    color: AppColors.secondary,
                  ),
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
              if (onCancel != null)
                TextButton(
                  onPressed: onCancel,
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Color(0xFFE35757),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              if (onRate != null)
                TextButton(
                  onPressed: onRate,
                  child: const Text(
                    'Calificar',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
