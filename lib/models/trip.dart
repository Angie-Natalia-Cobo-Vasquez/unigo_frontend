enum TripStatus { confirmed, cancelled, completed }

class Trip {
  final String passengerName;
  final String career;
  final String city;
  final String timeRange;
  final double price;
  final TripStatus status;
  final String imageUrl;

  const Trip({
    required this.passengerName,
    required this.career,
    required this.city,
    required this.timeRange,
    required this.price,
    required this.status,
    required this.imageUrl,
  });
}
