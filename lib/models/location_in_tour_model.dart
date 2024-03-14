class LocationInTourModel {
  final int id;
  final int locationId;
  final int tourId;
  final bool status;
  final String duration;
  final String description;
  final String startCity;
  final String endCity;
  final String locationName;
  final String locationAddress;
  final String locationImage;
  final String tourName;
  final String tourType;
  final String tourImage;
  final double price;
  final String vehicleName;
  final String vehicleCapacity;
  final DateTime createAt;

  LocationInTourModel({
    required this.id,
    required this.locationId,
    required this.tourId,
    required this.status,
    required this.duration,
    required this.description,
    required this.startCity,
    required this.endCity,
    required this.locationName,
    required this.locationAddress,
    required this.locationImage,
    required this.tourName,
    required this.tourImage,
    required this.price,
    required this.tourType,
    required this.vehicleName,
    required this.vehicleCapacity,
    required this.createAt,
  });

  factory LocationInTourModel.fromJson(Map<String, dynamic> json) {
    return LocationInTourModel(
      id: json['id'],
      locationId: json['locationId'],
      tourId: json['tourId'],
      status: json['status'],
      duration: json['duration'],
      description: json['description'],
      startCity: json['startCity'],
      endCity: json['endCity'],
      locationName: json['locationName'] ?? '',
      locationAddress: json['locationAddress'] ?? '',
      locationImage: json['locationImage'].toString().trim(),
      tourName: json['tourName'] ?? '',
      tourType: json['tourType'] ?? '',
      tourImage: json['tourImage'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      vehicleName: json['vehicleName'] ?? '',
      vehicleCapacity: json['vehicleCapacity'] ?? '',
      createAt: DateTime.parse(json['createAt']),
    );
  }

  @override
  String toString() {
    return 'LocationInTourModel{id: $id, tourId: $tourId, locationId: $locationId, duration: $duration, description: $description, startCity: $startCity, endCity: $endCity, locationName: $locationName, locationAddress: $locationAddress, tourName: $tourName, tourType: $tourType, price: $price, vehicleName: $vehicleName, tourImage: $tourImage, createAt: $createAt}';
  }
}
