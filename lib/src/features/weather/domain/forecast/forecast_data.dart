import 'package:google_intern_app/src/features/weather/domain/forecast/forecast.dart';
import 'package:google_intern_app/src/features/weather/domain/weather/weather_data.dart';

class ForecastData {
  const ForecastData(this.list);

  factory ForecastData.from(Forecast forecast) {
    return ForecastData(
      forecast.list.map((item) => WeatherData.from(item)).toList(),
    );
  }

  final List<WeatherData> list;

  Map<String, dynamic> toJson() => {
        'list': list.map((item) => item.toJson()).toList(),
      };

  factory ForecastData.fromJson(Map<String, dynamic> json) => ForecastData(
        (json['list'] as List)
            .map((item) => WeatherData.fromJson(item))
            .toList(),
      );
}
