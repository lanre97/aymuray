class Vegetable {
  final String name;
  final String? description;
  final List<String>? vitamins;
  final List<String>? minerals;
  final String? image;
  final String? icon;
  final VegetableEnvironment environment;

  const Vegetable(
      {required this.name,
      this.description,
      this.vitamins,
      this.minerals,
      this.image,
      this.icon,
      required this.environment});
}

class VegetableEnvironment {
  final double maximumSnowDeep;
  final double? optimalTopTemperature;
  final double? optimalLowerTemperature;
  final double? topTemperatureLimit;
  final double? lowerTemperatureLimit;
  final double? temperatureVariation;
  final double? maximumWindSpeed;
  final double? optimalHeight;
  final double? maximumLuminosity;
  final double? minimumLuminosity;
  final double? maximumPrecipitation;
  final double? minimumPrecipitation;
  final double? optimalSoilWetness;
  final double? harvestTime;

  bool get canCalcTempImportance =>
      optimalTopTemperature != null &&
      optimalLowerTemperature != null &&
      topTemperatureLimit != null &&
      lowerTemperatureLimit != null;

  bool get canCalcTempVaritionImportance => temperatureVariation != null;

  bool get canCalcWindSpeedImportance => maximumWindSpeed != null;

  bool get canCalcLuminicenceImportance =>
      maximumLuminosity != null && minimumLuminosity != null;

  bool get canCalcSoilWetnessImportance => optimalSoilWetness != null;

  bool get canCalcTempPenalty =>
      canCalcTempImportance && canCalcTempVaritionImportance;

  const VegetableEnvironment(
      {this.maximumSnowDeep = 0.2,
      this.optimalTopTemperature,
      this.optimalLowerTemperature,
      this.topTemperatureLimit,
      this.lowerTemperatureLimit,
      this.temperatureVariation,
      this.maximumWindSpeed,
      this.optimalHeight,
      this.maximumLuminosity,
      this.minimumLuminosity,
      this.maximumPrecipitation,
      this.minimumPrecipitation,
      this.optimalSoilWetness,
      this.harvestTime});
}

Vegetable examplePotato = Vegetable(
    name: 'Potato',
    environment: VegetableEnvironment(
        lowerTemperatureLimit: -2,
        topTemperatureLimit: 30,
        optimalLowerTemperature: 15,
        optimalTopTemperature: 20,
        maximumPrecipitation: 1200,
        maximumWindSpeed: 20 * 5 / 18,
        maximumLuminosity: 50000,
        minimumLuminosity: 20000,
        minimumPrecipitation: 500,
        optimalSoilWetness: 0.7,
        temperatureVariation: 10));
