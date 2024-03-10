class BookingModel {
  final int id;
  final DateTime bookingDate;
  final String userId;
  final double totalAmount;
  final bool status;
  final int tripId;
  final int totalCustomer;

  BookingModel({
    required this.id,
    required this.bookingDate,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.tripId,
    required this.totalCustomer,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      bookingDate: DateTime.parse(json['bookingDate']),
      userId: json['userId'],
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      tripId: json['tripId'],
      totalCustomer: json['totalCustomer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingDate': bookingDate.toIso8601String(),
      'userId': userId,
      'totalAmount': totalAmount,
      'status': status,
      'tripId': tripId,
      'totalCustomer': totalCustomer,
    };
  }
}
