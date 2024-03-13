class TripModel {
  final int id;
  final int tourId;
  final int totalCustomer;
  final String startDate;
  final String endDate;
  final bool status;
  final String tourGuideId;
  final String tourName;
  final String tourguideName;
  final String imageUrl;

  TripModel({
    required this.id,
    required this.tourId,
    required this.totalCustomer,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.tourGuideId,
    required this.tourName,
    required this.tourguideName,
    required this.imageUrl,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
        id: json['id'],
        tourId: json['tourId'],
        totalCustomer: json['totalCustomer'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        status: json['status'],
        tourGuideId: json['tourGuideId'],
        tourName: json['tourName'] ?? '',
        tourguideName: json['tourguideName'] ?? '',
        imageUrl: json['image'] ?? '');
  }

  @override
  String toString() {
    return 'Tripmodel: {id: $id, tourId: $tourId, totalCustomer: $totalCustomer, startDate: $startDate, endDate: $endDate, tourGuideId: $tourGuideId}, tourName: {$tourName}, tourGuideName: {$tourguideName}';
  }
}
