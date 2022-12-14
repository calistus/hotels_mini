import 'package:dio/dio.dart';
import 'package:hotels_mini/config/api_config.dart';
import 'package:hotels_mini/model/HotelModel.dart';

class HotelRepository {
  Future<HotelModel?> fetchHotels() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(baseURL);
      if (response.statusCode == 200) {
        return HotelModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      APIConfig.getPlatformExceptionErrorResult(e);
    }
  }
}
