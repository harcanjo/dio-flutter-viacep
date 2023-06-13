import 'package:dio/dio.dart';
import 'package:flutter_viacep/model/ceps_back4app_model.dart';

class CEPSBack4AppRepository {
  Future<CEPSBack4AppModel> getCPFs() async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "xxx";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "xxx";
    dio.options.headers["content-type"] = "application/json";
    var result = await dio.get("https://parseapi.back4app.com/classes/ceps");

    return CEPSBack4AppModel.fromJson(result.data);
  }

  Future<bool> cepExists(String cep) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "xxx";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "xxx";
    dio.options.headers["content-type"] = "application/json";
    var result = await dio.get(
        "https://parseapi.back4app.com/classes/ceps?where={\"cep\":\"$cep\"}");

    return result.data['results'].length > 0;
  }

  Future<void> registerCep(String cep) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "xxx";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "xxx";
    dio.options.headers["content-type"] = "application/json";
    await dio
        .post("https://parseapi.back4app.com/classes/ceps", data: {"cep": cep});
  }
}
