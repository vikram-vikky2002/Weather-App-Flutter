class Temperature {
  Temperature.celsius(this.celsius);

  factory Temperature.fahrenheit(double fahrenheit) =>
      Temperature.celsius((fahrenheit - 32) / 1.8);

  factory Temperature.kelvin(double kelvin) =>
      Temperature.celsius(kelvin - absoluteZero);

  static double absoluteZero = 273.15;

  final double celsius;

  double get fahrenheit => celsius * 1.8 + 32;

  Map<String, dynamic> toJson() => {
        'celsius': celsius,
      };

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      Temperature.celsius(json['celsius']);
}
