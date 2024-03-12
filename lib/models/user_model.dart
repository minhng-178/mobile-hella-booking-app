class UserModel {
  final bool status;
  final String id;
  final String fullName;
  final String email;
  final String password;
  final int roleId;
  final String phone;
  final String gender;
  final String image;
  final bool verified;

  UserModel(
      {required this.status,
      required this.id,
      required this.fullName,
      required this.email,
      required this.password,
      required this.roleId,
      required this.phone,
      required this.gender,
      required this.image,
      required this.verified});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        status: json['status'],
        id: json['_id'],
        fullName: json['fullName'],
        email: json['email'],
        password: json['password'],
        roleId: json['roleId'],
        phone: json['phone'],
        gender: json['gender'],
        image: json['image'],
        verified: json['verified']);
  }

  @override
  String toString() {
    return 'Usermodel{id: $id, email: $email,  fullName: $fullName, roleId: $roleId}';
  }
}
