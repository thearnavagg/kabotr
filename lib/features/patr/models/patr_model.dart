import 'dart:convert';

class PatrModel {
  final PatrDataModel patrs;
  final AdminDataModel admin;
  PatrModel({
    required this.patrs,
    required this.admin,
  });

  Map<String, dynamic> toMap() {
    return {
      'patrs': patrs.toMap(),
      'admin': admin.toMap(),
    };
  }

  factory PatrModel.fromMap(Map<String, dynamic> map) {
    return PatrModel(
      patrs: PatrDataModel.fromMap(map['patrs']),
      admin: AdminDataModel.fromMap(map['admin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PatrModel.fromJson(String source) =>
      PatrModel.fromMap(json.decode(source));
}

class AdminDataModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  // final DateTime createdAt;
  AdminDataModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      // 'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AdminDataModel.fromMap(Map<String, dynamic> map) {
    return AdminDataModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      // createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminDataModel.fromJson(String source) =>
      AdminDataModel.fromMap(json.decode(source));
}

class PatrDataModel {
  final String patrsId;
  final String content;
  final DateTime createdAt;
  final String adminId;
  PatrDataModel({
    required this.patrsId,
    required this.content,
    required this.createdAt,
    required this.adminId,
  });

  Map<String, dynamic> toMap() {
    return {
      'patrsId': patrsId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'adminId': adminId,
    };
  }

  factory PatrDataModel.fromMap(Map<String, dynamic> map) {
    return PatrDataModel(
      patrsId: map['patrsId'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      adminId: map['adminId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PatrDataModel.fromJson(String source) =>
      PatrDataModel.fromMap(json.decode(source));
}
