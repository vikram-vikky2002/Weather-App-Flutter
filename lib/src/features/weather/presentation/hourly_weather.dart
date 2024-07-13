import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_intern_app/src/features/weather/application/providers.dart';
import 'package:google_intern_app/src/features/weather/domain/weather/weather_data.dart';
import 'package:google_intern_app/src/features/weather/presentation/weather_icon_image.dart';
import 'package:intl/intl.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastDataValue = ref.watch(hourlyWeatherProvider);
    return forecastDataValue.when(
      data: (forecastData) {
        // API returns data points in 3-hour intervals -> 1 day = 8 intervals
        final items = [0, 8, 16, 24, 32];
        return HourlyWeatherRow(
          weatherDataItems: [
            for (var i in items) forecastData.list[i],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Text(e.toString()),
    );
  }
}

class HourlyWeatherRow extends StatelessWidget {
  const HourlyWeatherRow({super.key, required this.weatherDataItems});
  final List<WeatherData> weatherDataItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: weatherDataItems
          .map((data) => HourlyWeatherItem(data: data))
          .toList(),
    );
  }
}

class HourlyWeatherItem extends ConsumerWidget {
  const HourlyWeatherItem({super.key, required this.data});
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temp = data.temp.celsius.toInt().toString();
    return Expanded(
      child: Column(
        children: [
          Text(
            DateFormat.E().format(data.date),
            style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 15,
                color: Color.fromARGB(154, 255, 255, 255)),
          ),
          // const SizedBox(height: 8),
          WeatherIconImage(iconUrl: data.iconUrl, size: 55),
          // const SizedBox(height: 8),
          Text(
            '$temp°',
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 17,
              color: Color.fromARGB(154, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
