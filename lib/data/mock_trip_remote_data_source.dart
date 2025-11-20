import 'dart:async';

import '../models/trip.dart';

class MockTripRemoteDataSource {
  Future<List<Trip>> fetchTrips() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return const [
      Trip(
        passengerName: 'Daniela Jojoa',
        career: 'Psicología',
        city: 'Buga',
        timeRange: 'Lun 25 · 4:00 PM',
        price: 8000,
        status: TripStatus.confirmed,
        imageUrl: 'assets/images/Daniela.png',
      ),
      Trip(
        passengerName: 'Pedro Lucumí',
        career: 'Derecho',
        city: 'Buenaventura',
        timeRange: 'Jue 21 · 3:00 PM',
        price: 10000,
        status: TripStatus.completed,
        imageUrl: 'assets/images/Pedro.png',
      ),
      Trip(
        passengerName: 'Giamcito-kun',
        career: 'Medicina',
        city: 'Trujillo',
        timeRange: 'Vie 22 · 10:00 AM',
        price: 15000,
        status: TripStatus.cancelled,
        imageUrl: 'assets/images/kun.png',
      ),
    ];
  }
}
