import 'package:travo_app/models/user_model.dart';

class TourGuideModel {
  final String id;
  final UserModel user;
  final bool status;
  final List<String> language;

  TourGuideModel({
    required this.id,
    required this.user,
    required this.status,
    required this.language,
  });

  factory TourGuideModel.fromJson(Map<String, dynamic> json) {
    return TourGuideModel(
      id: json['_id'],
      user: UserModel.fromJson(json['userId']),
      status: json['status'],
      language: List<String>.from(json['language']),
    );
  }

  @override
  String toString() {
    return 'TourGuideModel: id: $id, user: $user';
  }
}
