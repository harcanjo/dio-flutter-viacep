import 'package:dio/dio.dart';
import 'package:flutter_viacep/model/ceps_back4app_model.dart';

class CEPSBack4AppRepository {
  Future<CEPSBack4AppModel> getCPFs() async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "KEY-BACK4APP";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "KEY-BACK4APP";
    dio.options.headers["content-type"] = "application/json";
    var result = await dio.get("https://parseapi.back4app.com/classes/ceps");

    return CEPSBack4AppModel.fromJson(result.data);
  }

  Future<bool> cepExists(String cep) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "KEY-BACK4APP";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "KEY-BACK4APP";
    dio.options.headers["content-type"] = "application/json";
    var result = await dio.get(
        "https://parseapi.back4app.com/classes/ceps?where={\"cep\":\"$cep\"}");

    return result.data['results'].length > 0;
  }

  Future<void> registerCep(String cep) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "KEY-BACK4APP";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "KEY-BACK4APP";
    dio.options.headers["content-type"] = "application/json";
    await dio
        .post("https://parseapi.back4app.com/classes/ceps", data: {"cep": cep});
  }

  Future<void> updateCPF(String objectId, Map<String, dynamic> data) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "KEY-BACK4APP";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "KEY-BACK4APP";
    dio.options.headers["content-type"] = "application/json";
    await dio.put(
      "https://parseapi.back4app.com/classes/ceps/$objectId",
      data: data,
    );
  }

  Future<void> deleteCPF(String objectId) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "KEY-BACK4APP";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "KEY-BACK4APP";
    dio.options.headers["content-type"] = "application/json";
    await dio.delete(
      "https://parseapi.back4app.com/classes/ceps/$objectId",
    );
  }
}
