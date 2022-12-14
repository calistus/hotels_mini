import 'package:dio/dio.dart';

const baseURL = "https://run.mocky.io/v3/eef3c24d-5bfd-4881-9af7-0b404ce09507";

class APIConfig {
  static Exception getPlatformExceptionErrorResult(e) {
    if (e.response != null) {
      print(e.requestOptions.data);
      print(e.toString());
      throw Exception(e.toString());
    } else {
      throw Exception("Something went wrong");
    }
  }
}
