class TourModel {
  final int id;
  final String tourName;
  final bool status;
  final double price;
  final int vehicleTypeId;
  final String tourType;
  final String? image;

  TourModel({
    required this.id,
    required this.tourName,
    required this.status,
    required this.price,
    required this.tourType,
    required this.vehicleTypeId,
    this.image,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'],
      tourName: json['tourName'],
      status: json['status'],
      price: json['price'].toDouble(),
      vehicleTypeId: json['vehicleTypeId'],
      tourType: json['tourType'],
      image: json['image'],
    );
  }
}
