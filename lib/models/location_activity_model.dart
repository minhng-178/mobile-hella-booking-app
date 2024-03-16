class LocationActivityModel {
  final int id;
  final int locationId;
  final String activityName;
  final String activityDuration;
  final String activityDescription;
  final bool status;

  LocationActivityModel({
    required this.id,
    required this.locationId,
    required this.activityName,
    required this.activityDuration,
    required this.activityDescription,
    required this.status,
  });

  factory LocationActivityModel.fromJson(Map<String, dynamic> json) {
    return LocationActivityModel(
      id: json['id'],
      locationId: json['locationId'],
      activityName: json['activityName'],
      activityDuration: json['activityDuration'].toString(),
      activityDescription: json['activityDescription'] ?? "",
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'LocationActivityModel: {id: $id, activityName: $activityName, activityDuration: $activityDuration, $activityDescription}';
  }
}
