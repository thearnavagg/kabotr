// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:kabotr/core/api-services/config.dart';
// import 'package:kabotr/features/auth/model/user_model.dart';

// class AuthRepo {
//   static Future<UserModel?> getUserRepo(String uid) async {
//     try {
//       Dio dio = Dio();
//       final url = "${Config.serverUrl}user/$uid";
//       log("Attempting to GET: $url");
//       final response = await dio.get(url);

//       if (response.statusCode! >= 200 && response.statusCode! <= 300) {
//         log(response.data.toString());
//         UserModel userModel = UserModel.fromMap(response.data);
//         return userModel;
//       } else {
//         log("Error: Received status code ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       log("Exception: $e");
//       return null;
//     }
//   }

//   static Future<bool> createUserRepo(UserModel userModel) async {
//     try {
//       Dio dio = Dio();
//       final url = "${Config.serverUrl}user";
//       log("Attempting to POST: $url with data: ${userModel.toMap()}");
//       final response = await dio.post(url, data: userModel.toMap());

//       if (response.statusCode! >= 200 && response.statusCode! <= 300) {
//         return true;
//       } else {
//         log("Error: Received status code ${response.statusCode}");
//         return false;
//       }
//     } catch (e) {
//       log("Exception: $e");
//       return false;
//     }
//   }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kabotr/core/api-services/config.dart';
import 'package:kabotr/features/auth/model/user_model.dart';

class AuthRepo {
  static Future<UserModel?> getUserRepo(String uid) async {
    try {
      Dio dio = Dio();
      final response = await dio.get("${Config.serverUrl}user/$uid");

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        UserModel userModel = UserModel.fromMap(response.data);
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
    final response =
        await dio.post("${Config.serverUrl}user", data: userModel.toMap());
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return true;
    } else {
      return false;
    }
  }
}
