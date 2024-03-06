class TripModel {
  final int id;
  final int tourId;
  final int totalCustomer;
  final DateTime startDate;
  final DateTime endDate;
  final bool status;
  final int tourGuideId;

  TripModel({
    required this.id,
    required this.tourId,
    required this.totalCustomer,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.tourGuideId,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      tourId: json['tourId'],
      totalCustomer: json['totalCustomer'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      tourGuideId: json['tourGuideId'],
    );
  }

  @override
  String toString() {
    return 'Tourmodel: {id: $id, tourId: $tourId, totalCustomer: $totalCustomer, startDate: $startDate, endDate: $endDate, tourGuideId: $tourGuideId}';
  }
}
