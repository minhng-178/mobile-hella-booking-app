class TourModel {
  final int id;
  final String tourName;
  final bool status;
  final int price;
  final int vehicleTypeId;
  final String tourType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Null deleteAt;
  final Null image;

  TourModel({
    required this.id,
    required this.tourName,
    required this.status,
    required this.price,
    required this.vehicleTypeId,
    required this.tourType,
    required this.createdAt,
    required this.updatedAt,
    this.deleteAt,
    this.image,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'],
      tourName: json['tourName'] ?? '',
      status: json['status'],
      price: json['price'],
      vehicleTypeId: json['vehicleTypeId'],
      tourType: json['tourType'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deleteAt: null,
      image: null,
    );
  }
}
