import 'driver.dart';

class BookingDetails {
  BookingDetails({
    required this.driver,
    required this.dayLabel,
    required this.dateLabel,
    required this.timeLabel,
    required this.seats,
  });

  final Driver driver;
  final String dayLabel;
  final String dateLabel;
  final String timeLabel;
  final int seats;

  String get formattedSchedule => '$dayLabel $dateLabel · $timeLabel';
}
