class Environment {
  final int year;
  final int? month;
  final double? luminescence;
  final double? soilWetness;
  final double? windSpeed;
  final double? temperatureAt2Meters;
  final double? maxTemperatureAt2Meters;
  final double? minTemperatureAt2Meters;
  final double snowDeep;
  final double precipitation;

  bool get canCalcTempImportance => (temperatureAt2Meters ?? -999) >= -273;

  bool get canCalcTempVaritionImportance =>
      (maxTemperatureAt2Meters ?? -999) >= -273 &&
      (minTemperatureAt2Meters ?? -999) >= -273;

  bool get canCalcWindSpeedImportance => (windSpeed ?? -9) >= 0;

  bool get canCalcLuminicenceImportance => (luminescence ?? -9) >= 0;

  bool get canCalcSoilWetnessImportance => (soilWetness ?? -9) >= 0;

  bool get canCalcTempPenalty =>
      canCalcTempImportance && canCalcTempVaritionImportance;

  Environment(
      {required this.year,
      this.month,
      this.luminescence,
      this.soilWetness,
      this.windSpeed,
      this.temperatureAt2Meters,
      this.maxTemperatureAt2Meters,
      this.minTemperatureAt2Meters,
      this.snowDeep = 0,
      this.precipitation = 0});

  Environment copyWith(
      double? luminescence,
      double? soilWetness,
      double? windSpeed,
      double? temperatureAt2Meters,
      double? maxTemperatureAt2Meters,
      double? minTemperatureAt2Meters,
      double? snowDeep,
      double? precipitation) {
    return Environment(
        year: this.year,
        month: this.month,
        luminescence: luminescence ?? this.luminescence,
        soilWetness: soilWetness ?? this.soilWetness,
        windSpeed: windSpeed ?? this.windSpeed,
        temperatureAt2Meters: temperatureAt2Meters ?? this.temperatureAt2Meters,
        maxTemperatureAt2Meters:
            maxTemperatureAt2Meters ?? this.maxTemperatureAt2Meters,
        minTemperatureAt2Meters:
            minTemperatureAt2Meters ?? this.minTemperatureAt2Meters,
        snowDeep: snowDeep ?? this.snowDeep,
        precipitation: precipitation ?? this.precipitation);
  }

  Environment update(
      {double? luminescence,
      double? soilWetness,
      double? windSpeed,
      double? temperatureAt2Meters,
      double? maxTemperatureAt2Meters,
      double? minTemperatureAt2Meters,
      double? snowDeep,
      double? precipitation}) {
    return copyWith(
        luminescence,
        soilWetness,
        windSpeed,
        temperatureAt2Meters,
        maxTemperatureAt2Meters,
        minTemperatureAt2Meters,
        snowDeep,
        precipitation);
  }
}