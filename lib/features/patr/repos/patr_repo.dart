import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kabotr/core/api-services/config.dart';
import 'package:kabotr/features/patr/models/patr_model.dart';

class PatrRepo {
  static Future<List<PatrModel>> getAllPatrs() async {
    try {
      Dio dio = Dio();
      final response = await dio.get('${Config.serverUrl}patr/get/all');
      List<PatrModel> patrs = [];
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        for (int i = 0; i < response.data['data'].length; i++) {
          patrs.add(PatrModel.fromMap(response.data['data'][i]));
        }
      }
      return patrs;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
