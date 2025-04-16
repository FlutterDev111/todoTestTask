class UserModel {
  final String fullName;
  final String email;
  final String dateOfBirth;
  final String phoneNumber;

  UserModel({
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
    };
  }
} 