class VehicleModel {
  final int id;
  final String vehicleName;
  final bool status;

  VehicleModel({
    required this.id,
    required this.vehicleName,
    required this.status,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
        id: json['id'], vehicleName: json['name'], status: json["status"]);
  }
}
