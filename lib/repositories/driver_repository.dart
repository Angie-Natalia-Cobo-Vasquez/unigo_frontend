import '../data/mock_driver_remote_data_source.dart';
import '../models/driver.dart';

class DriverRepository {
  DriverRepository({MockDriverRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? MockDriverRemoteDataSource();

  final MockDriverRemoteDataSource _remoteDataSource;

  Future<List<Driver>> getDrivers() => _remoteDataSource.fetchDrivers();
}
