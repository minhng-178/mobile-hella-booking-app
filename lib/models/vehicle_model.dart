class VehicleModel {
  final int id;
  final String vehicleName;
  final bool status;
  final String capacity;

  VehicleModel({
    required this.id,
    required this.status,
    required this.vehicleName,
    required this.capacity,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      status: json['status'],
      vehicleName: json['vehicleName'],
      capacity: json['capacity'],
    );
  }

  @override
  String toString() {
    return 'VehicleModel{id: $id, vehicleName: $vehicleName}';
  }
}
