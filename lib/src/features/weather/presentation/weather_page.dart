import 'package:flutter/material.dart';
import 'package:weather_app/src/constants/app_colors.dart';
import 'package:weather_app/src/features/weather/presentation/city_search_box.dart';
import 'package:weather_app/src/features/weather/presentation/current_weather.dart';
import 'package:weather_app/src/features/weather/presentation/hourly_weather.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({
    super.key,
  });
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.rainGradient,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Weather App",
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const CitySearchBox(),
                  const CurrentWeather(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(55, 0, 0, 0),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            "5-days Forecast",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 20),
                        const HourlyWeather(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
