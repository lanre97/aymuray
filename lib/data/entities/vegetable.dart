class Vegetable{
  final String name;
  final String? description;
  final List<String>? vitamins;
  final List<String>? minerals;
  final String? image;
  final String? icon;
  final VegetableEnvironment environment;

  const Vegetable({
    required this.name, 
    this.description, 
    this.vitamins, 
    this.minerals, 
    this.image, 
    this.icon,
    required this.environment
  });

}
  

class VegetableEnvironment{
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
  final double? optimalHumidity;
  final double? harvestTime;

  const VegetableEnvironment({
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
    this.optimalHumidity,
    this.harvestTime
  });
}
