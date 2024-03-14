class BookingModel {
  final int id;
  final String bookingDate;
  final String userId;
  final double totalAmount;
  final bool status;
  final int tripId;
  final int totalCustomer;
  final String startDate;
  final String endDate;
  final String tourName;
  final String tourguideName;
  final String tourImage;

  BookingModel(
      {required this.id,
      required this.bookingDate,
      required this.userId,
      required this.totalAmount,
      required this.status,
      required this.tripId,
      required this.totalCustomer,
      required this.startDate,
      required this.endDate,
      required this.tourName,
      required this.tourguideName,
      required this.tourImage});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      bookingDate: json['bookingDate'],
      userId: json['userId'],
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      tripId: json['tripId'],
      totalCustomer: json['totalCustomer'],
      startDate: json['startDate'] ?? 'N/A',
      endDate: json['endDate'] ?? 'N/A',
      tourName: json['tourName'] ?? 'N/A',
      tourguideName: json['tourguideName'] ?? 'N/A',
      tourImage: json['tourImage'] ?? 'N/A',
    );
  }

  @override
  String toString() {
    return 'BookingModel: {id: $id, bookingDate: $bookingDate, userId: $userId, tripId: $tripId , startDate: $startDate, endDate: $endDate, tourName: {$tourName}, tourGuideName: {$tourguideName}}';
  }
}
