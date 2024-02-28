class LocationInTourModel {
  final int id;
  final int locationId;
  final int tourId;
  final bool status;
  final String duration;
  final String description;
  final String startCity;
  final String endCity;

  LocationInTourModel({
    required this.id,
    required this.locationId,
    required this.tourId,
    required this.status,
    required this.duration,
    required this.description,
    required this.startCity,
    required this.endCity,
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
    );
  }

  @override
  String toString() {
    return 'LocationInTourModel{id: $id, duration: $duration, startCity: $startCity, endCity: $endCity}';
  }
}
