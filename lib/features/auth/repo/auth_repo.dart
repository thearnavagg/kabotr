import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kabotr/core/api-services/config.dart';
import 'package:kabotr/features/auth/model/user_model.dart';

class AuthRepo {
  static Future<UserModel?> getUserRepo(String uid) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(Config.serverUrl = "user/$uid");
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        UserModel userModel = UserModel.fromJson(response.data);
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> createUserRepo(UserModel userModel) async {
    Dio dio = Dio();
    final response = await dio.post(Config.serverUrl = "user");
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return true;
    } else {
      return false;
    }
  }
}
