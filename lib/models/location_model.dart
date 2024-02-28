class LocationModel {
  final int id;
  final int cityId;
  final String locationName;
  final String locationAddress;
  final bool status;
  final String? image;

  LocationModel({
    required this.id,
    required this.cityId,
    required this.locationName,
    required this.locationAddress,
    required this.status,
    this.image,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      cityId: json['cityId'],
      locationName: json['locationName'],
      locationAddress: json['locationAddress'],
      status: json['status'],
      image: json['image'],
    );
  }

  @override
  String toString() {
    return 'LocationModel{id: $id, locationName: $locationName, locationAddress: $locationAddress}';
  }
}
