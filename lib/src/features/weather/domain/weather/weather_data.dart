import 'package:google_intern_app/src/features/weather/domain/temperature.dart';
import 'package:google_intern_app/src/features/weather/domain/weather/weather.dart';

class WeatherData {
  WeatherData({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.date,
    required this.icon,
  });

  factory WeatherData.from(Weather weather) {
    return WeatherData(
      temp: Temperature.celsius(weather.weatherParams.temp),
      minTemp: Temperature.celsius(weather.weatherParams.tempMin),
      maxTemp: Temperature.celsius(weather.weatherParams.tempMax),
      description: weather.weatherInfo[0].main,
      date: DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000),
      icon: weather.weatherInfo[0].icon,
    );
  }

  final Temperature temp;
  final Temperature minTemp;
  final Temperature maxTemp;
  final String description;
  final DateTime date;
  final String icon;

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";

  Map<String, dynamic> toJson() => {
        'temp': temp.celsius,
        'minTemp': minTemp.celsius,
        'maxTemp': maxTemp.celsius,
        'description': description,
        'date': date.millisecondsSinceEpoch,
        'icon': icon,
      };

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        temp: Temperature.celsius(json['temp']),
        minTemp: Temperature.celsius(json['minTemp']),
        maxTemp: Temperature.celsius(json['maxTemp']),
        description: json['description'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        icon: json['icon'],
      );
}
