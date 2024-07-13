import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weather_app/src/features/weather/domain/weather/weather_data.dart';
import 'package:weather_app/src/features/weather/domain/forecast/forecast_data.dart';

class SharedPreferencesUtil {
  static const String _cityKey = 'city_name';
  static const String _weatherKey = 'weather_data';
  static const String _forecastKey = 'forecast_data';

  Future<void> saveCityName(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cityKey, cityName);
  }

  Future<String?> getCityName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cityKey);
  }

  Future<void> saveWeatherData(WeatherData weatherData) async {
    final prefs = await SharedPreferences.getInstance();
    final weatherJson = jsonEncode(weatherData.toJson());
    await prefs.setString(_weatherKey, weatherJson);
  }

  Future<WeatherData?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherJson = prefs.getString(_weatherKey);
    if (weatherJson == null) return null;
    return WeatherData.fromJson(jsonDecode(weatherJson));
  }

  Future<void> saveForecastData(ForecastData forecastData) async {
    final prefs = await SharedPreferences.getInstance();
    final forecastJson = jsonEncode(forecastData.toJson());
    await prefs.setString(_forecastKey, forecastJson);
  }

  Future<ForecastData?> getForecastData() async {
    final prefs = await SharedPreferences.getInstance();
    final forecastJson = prefs.getString(_forecastKey);
    if (forecastJson == null) return null;
    return ForecastData.fromJson(jsonDecode(forecastJson));
  }
}
