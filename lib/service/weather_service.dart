import 'package:dio/dio.dart';
import 'package:weather_app/models/models.dart';

class WeatherService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.openweathermap.org/data/2.5/",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {"Accept": "application/json"},
    ),
  );
  final apiKey = 'your_api_key';
  Future<WeatherModel> getWeather(String? city) async {
    try {
      final response = await dio.get(
        'weather',
        queryParameters: {'APPID': apiKey, 'q': city},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.data;
        print('111111111111111111111111');
        print(body);
        WeatherModel weatherData = WeatherModel.fromJson(body);
        return weatherData;
      } else {
        throw Exception('Error in fetching weather');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    } finally {
      print('Success');
    }
  }
}
