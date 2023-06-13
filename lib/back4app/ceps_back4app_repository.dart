import 'package:dio/dio.dart';
import 'package:flutter_viacep/model/ceps_back4app_model.dart';

class CEPSBack4AppRepository {
  Future<CEPSBack4AppModel> getCPFs() async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = "XXX";
    dio.options.headers["X-Parse-REST-API-Key"] = "XXX";
    dio.options.headers["content-type"] = "application/json";
    var result = await dio.get("XXX");

    return CEPSBack4AppModel.fromJson(result.data);
  }
}
