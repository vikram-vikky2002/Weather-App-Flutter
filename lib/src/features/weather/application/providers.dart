import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_intern_app/src/features/weather/application/sharedPref.dart';
import 'package:google_intern_app/src/features/weather/data/weather_repository.dart';
import 'package:google_intern_app/src/features/weather/domain/forecast/forecast_data.dart';
import 'package:google_intern_app/src/features/weather/domain/weather/weather_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedPreferencesUtilProvider = Provider<SharedPreferencesUtil>((ref) {
  return SharedPreferencesUtil();
});

final connectivityProvider = StreamProvider<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

final cityProvider = StateNotifierProvider<CityNotifier, String>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return CityNotifier(sharedPreferences);
});

class CityNotifier extends StateNotifier<String> {
  final SharedPreferences _prefs;
  static const String _cityKey = 'city_name';

  CityNotifier(this._prefs) : super('Chennai') {
    _loadCity();
  }

  void _loadCity() {
    final city = _prefs.getString(_cityKey) ?? 'Chennai';
    state = city;
  }

  Future<void> setCity(String city) async {
    state = city;
    await _prefs.setString(_cityKey, city);
  }
}

final currentWeatherProvider =
    FutureProvider.autoDispose<WeatherData>((ref) async {
  final city = ref.watch(cityProvider);
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final sharedPreferencesUtil = ref.watch(sharedPreferencesUtilProvider);
  final connectivityResult = ref.watch(connectivityProvider).asData?.value;

  WeatherData? weatherData = await sharedPreferencesUtil.getWeatherData();

  if (connectivityResult == ConnectivityResult.none) {
    if (weatherData != null) {
      return weatherData;
    } else {
      throw Exception('No internet connection and no cached data available');
    }
  } else {
    try {
      final weather = await weatherRepository.getWeather(city: city);
      weatherData = WeatherData.from(weather);
      await sharedPreferencesUtil.saveWeatherData(weatherData);
    } catch (e) {
      if (weatherData != null) {
        return weatherData;
      } else {
        throw Exception('Failed to fetch data and no cached data available');
      }
    }
  }

  return weatherData;
});

final hourlyWeatherProvider =
    FutureProvider.autoDispose<ForecastData>((ref) async {
  final city = ref.watch(cityProvider);
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final sharedPreferencesUtil = ref.watch(sharedPreferencesUtilProvider);
  final connectivityResult = ref.watch(connectivityProvider).asData?.value;

  ForecastData? forecastData = await sharedPreferencesUtil.getForecastData();

  if (connectivityResult == ConnectivityResult.none) {
    if (forecastData != null) {
      return forecastData;
    } else {
      throw Exception('No internet connection and no cached data available');
    }
  } else {
    try {
      final forecast = await weatherRepository.getForecast(city: city);
      forecastData = ForecastData.from(forecast);
      await sharedPreferencesUtil.saveForecastData(forecastData);
    } catch (e) {
      if (forecastData != null) {
        return forecastData;
      } else {
        throw Exception('Failed to fetch data and no cached data available');
      }
    }
  }

  return forecastData;
});
