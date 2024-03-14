class PaymentModel {
  final int id;
  final int bookingId;
  final String paymentName;
  final DateTime paymentDate;
  final double amount;
  final bool status;
  final String bookingDate;
  final int totalCustomer;
  final String startDate;
  final String endDate;
  final String tourName;
  final String tourguideName;
  final String tourImage;

  PaymentModel(
      {required this.id,
      required this.bookingId,
      required this.paymentName,
      required this.paymentDate,
      required this.amount,
      required this.status,
      required this.bookingDate,
      required this.totalCustomer,
      required this.startDate,
      required this.endDate,
      required this.tourName,
      required this.tourguideName,
      required this.tourImage});

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
        id: json['id'],
        bookingId: json['bookingId'],
        paymentName: json['paymentName'],
        paymentDate: DateTime.parse(json['paymentDate']),
        amount: json['amount'].toDouble(),
        status: json['status'],
        bookingDate: json['bookingDate'] ?? 'Not Available',
        totalCustomer: json['totalCustomer'] ?? 0,
        startDate: json['startDate'] ?? 'Not Available',
        endDate: json['endDate'] ?? 'Not Available',
        tourName: json['tourName'] ?? '',
        tourguideName: json['tourguideName'] ?? '',
        tourImage: json['tourImage'] ?? '');
  }

  @override
  String toString() {
    return 'PaymentModel: {Booking date: $bookingDate, payment date: $paymentDate, tourName: $tourName, tourguideName: $tourguideName, totalCustomer: $totalCustomer, totalAmount: $amount, tourImage: $tourImage}';
  }
}
