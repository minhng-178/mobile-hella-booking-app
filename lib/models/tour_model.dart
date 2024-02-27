class TourModel {
  final int id;
  final String tourName;
  final bool status;
  final double price;
  final String vehicleName;
  final String vehicleCapacity;
  final String tourType;
  final String? image;

  TourModel({
    required this.id,
    required this.tourName,
    required this.status,
    required this.price,
    required this.tourType,
    required this.vehicleName,
    required this.vehicleCapacity,
    this.image,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'],
      tourName: json['tourName'],
      status: json['status'],
      price: json['price'].toDouble(),
      vehicleName: json['vehicleName'],
      vehicleCapacity: json['vehicleCapacity'],
      tourType: json['tourType'],
      image: json['image'],
    );
  }
}
