class UserModel {
  final String uid;
  final List<String> patrs;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.patrs,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'patrs': patrs,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      patrs: List<String>.from(json['patrs']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
