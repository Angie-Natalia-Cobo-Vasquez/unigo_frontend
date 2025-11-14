import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/bottom_navbar.dart';

class FilterTripsScreen extends StatefulWidget {
  const FilterTripsScreen({super.key});

  @override
  State<FilterTripsScreen> createState() => _FilterTripsScreenState();
}

class _FilterTripsScreenState extends State<FilterTripsScreen> {
  int _currentIndex = 1;
  String _selectedService = 'Carro';
  int _selectedSeats = 1;
  RangeValues _priceRange = const RangeValues(5, 30);
  String _selectedCity = 'Ciudad Municipio';

  String _formatCurrency(double value) => '\$${value.toStringAsFixed(0)}.000';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
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
                    'Filtro de búsqueda',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _FilterSection(
                title: 'Tipo de servicio',
                child: Column(
                  children: [
                    _RadioTile(
                      label: 'Carro',
                      groupValue: _selectedService,
                      onChanged: (value) => setState(() => _selectedService = value),
                    ),
                    _RadioTile(
                      label: 'Moto',
                      groupValue: _selectedService,
                      onChanged: (value) => setState(() => _selectedService = value),
                    ),
                    _RadioTile(
                      label: 'Bus',
                      groupValue: _selectedService,
                      onChanged: (value) => setState(() => _selectedService = value),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _FilterSection(
                title: 'Cupos disponibles',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    final seatNumber = index + 1;
                    final isSelected = _selectedSeats == seatNumber;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == 3 ? 0 : 12),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedSeats = seatNumber),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.secondary : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x11000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.event_seat,
                                  color: isSelected ? Colors.white : AppColors.textSecondary,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '$seatNumber',
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              _FilterSection(
                title: 'Ciudad/Municipio',
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x11000000),
                        blurRadius: 12,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCity,
                      items: const [
                        DropdownMenuItem(
                          value: 'Ciudad Municipio',
                          child: Text('Ciudad Municipio'),
                        ),
                        DropdownMenuItem(
                          value: 'Buga',
                          child: Text('Buga'),
                        ),
                        DropdownMenuItem(
                          value: 'Tuluá',
                          child: Text('Tuluá'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedCity = value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _FilterSection(
                title: 'Precio',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RangeSlider(
                      values: _priceRange,
                      min: 5,
                      max: 30,
                      divisions: 25,
                      activeColor: AppColors.secondary,
                      inactiveColor: AppColors.neutral,
                      labels: RangeLabels(
                        _formatCurrency(_priceRange.start),
                        _formatCurrency(_priceRange.end),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _priceRange = RangeValues(values.start, values.end);
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatCurrency(_priceRange.start),
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                        Text(
                          _formatCurrency(_priceRange.end),
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
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

class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _RadioTile extends StatelessWidget {
  final String label;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const _RadioTile({
    required this.label,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = label == groupValue;
    return GestureDetector(
      onTap: () => onChanged(label),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 12,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: AppColors.secondary,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
