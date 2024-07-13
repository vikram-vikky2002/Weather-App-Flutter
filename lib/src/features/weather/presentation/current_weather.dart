import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/src/features/weather/application/providers.dart';
import 'package:weather_app/src/features/weather/domain/weather/weather_data.dart';
import 'package:weather_app/src/features/weather/presentation/weather_icon_image.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        Text(
          city,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 40,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Text(
            "Today",
            style: TextStyle(
              fontFamily: 'Outfit-Light',
              fontSize: 30,
            ),
          ),
        ),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Text(
            e.toString(),
            style: const TextStyle(
              fontFamily: 'Outfit',
            ),
          ),
        ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({super.key, required this.data});
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temp = data.temp.celsius.toInt().toString();
    final status = data.description.toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    // final highAndLow = '$minTemp° / $maxTemp°';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 120),
        Text(
          '$temp° C',
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 80,
          ),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 0.6,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            status,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 20,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                "$minTemp°",
                style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    color: Color.fromARGB(255, 112, 188, 255)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                " / ",
                style: TextStyle(
                  fontFamily: 'Outfit-Light',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                "$maxTemp°",
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 199, 132),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
