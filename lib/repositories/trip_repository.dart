import 'dart:async';

import '../data/mock_trip_remote_data_source.dart';
import '../models/trip.dart';

class TripRepository {
  TripRepository._internal({MockTripRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? MockTripRemoteDataSource(),
      _controller = StreamController<List<Trip>>.broadcast() {
    _controller.onListen = () {
      if (_initialized) {
        _emitCurrentTrips();
      } else {
        unawaited(_ensureInitialized());
      }
    };
  }

  static final TripRepository _instance = TripRepository._internal();

  factory TripRepository() => _instance;

  final MockTripRemoteDataSource _remoteDataSource;
  final List<Trip> _trips = [];
  final StreamController<List<Trip>> _controller;
  bool _initialized = false;

  void _emitCurrentTrips() {
    if (!_controller.hasListener) return;
    _controller.add(List.unmodifiable(_trips));
  }

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    final remoteTrips = await _remoteDataSource.fetchTrips();
    _trips
      ..clear()
      ..addAll(remoteTrips);
    _initialized = true;
    _emitCurrentTrips();
  }

  Future<List<Trip>> getTrips() async {
    await _ensureInitialized();
    return List.unmodifiable(_trips);
  }

  Stream<List<Trip>> watchTrips() {
    unawaited(_ensureInitialized());
    return _controller.stream;
  }

  Future<void> addTrip(Trip trip) async {
    await _ensureInitialized();
    _trips.insert(0, trip);
    _emitCurrentTrips();
  }

  Future<bool> removeTrip(Trip trip) async {
    await _ensureInitialized();
    final removed = _trips.remove(trip);
    if (removed) {
      _emitCurrentTrips();
    }
    return removed;
  }
}
