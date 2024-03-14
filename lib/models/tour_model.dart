class TourModel {
  final int id;
  final String tourName;
  final bool status;
  final double price;
  final String tourType;
  final int vehicleTypeId;
  final String vehicleName;
  final String vehicleCapacity;
  final String image;

  TourModel({
    required this.id,
    required this.tourName,
    required this.status,
    required this.price,
    required this.tourType,
    required this.vehicleTypeId,
    required this.vehicleName,
    required this.vehicleCapacity,
    required this.image,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'],
      tourName: json['tourName'],
      status: json['status'],
      price: json['price'].toDouble(),
      tourType: json['tourType'],
      vehicleTypeId: json['vehicleTypeId'],
      vehicleName: json['vehicleName'] ?? '',
      vehicleCapacity: json['vehicleCapacity'].toString(),
      image: json['image']?.toString().trim() ??
          'https://icrier.org/wp-content/uploads/2022/09/Event-Image-Not-Found.jpg',
    );
  }
  @override
  String toString() {
    return 'TourModel{id: $id, tourName: $tourName, tourType: $tourType}';
  }
}
