import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kabotr/core/api-services/config.dart';

class CreatePatrRepo {
  static Future<bool> postPatrRepo(
      String patrId, adminId, content, DateTime createdAt) async {
    try {
      Dio dio = Dio();

      final response = await dio.post('${Config.serverUrl}patr', data: {
        'patrId': patrId,
        'adminId': adminId,
        'content': content,
        'createdAt': createdAt.toIso8601String()
      });
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
