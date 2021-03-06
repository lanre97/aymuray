class Vegetable {
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

  factory Vegetable.fromJson(Map<String,dynamic> json)=>Vegetable(
    name: json['name'], 
    description: json['description'],
    vitamins: json['vitamins'].cast<String>(),
    minerals: json['minerals'].cast<String>(),
    image: json['image'],
    icon: json['icon'],
    environment: VegetableEnvironment.fromJson(json['environment'])
  );

  /*factory Vegetable.fromJson(Map<String, dynamic> json) => Vegetable(
      name: json['name'],
      description: json['description'],
      vitamins: json['vitamins'],
      minerals: json['minerals'],
      image: json['image'],
      icon: json['icon'],
      environment: json['environment']);*/
}

class VegetableEnvironment {
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
  final double? maximumSnowDeep;

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
      {this.maximumSnowDeep,
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

  factory VegetableEnvironment.fromJson(Map<String, dynamic> json)=>
    VegetableEnvironment(
      maximumSnowDeep:json['maximumSnowDeep']?.toDouble(),
      optimalTopTemperature: json['optimalTopTemperature']?.toDouble(),
      optimalLowerTemperature: json['optimalLowerTemperature']?.toDouble(),
      topTemperatureLimit: json['topTemperatureLimit']?.toDouble(),
      lowerTemperatureLimit: json['lowerTemperatureLimit']?.toDouble(),
      temperatureVariation: json['temperatureVariation']?.toDouble(),
      maximumWindSpeed: json['maximumWindSpeed']?.toDouble(),
      optimalHeight: json['optimalHeight']?.toDouble(),
      maximumLuminosity: json['maximumLuminosity']?.toDouble(),
      minimumLuminosity: json['minimumLuminosity']?.toDouble(),
      maximumPrecipitation: json['maximumPrecipitation']?.toDouble(),
      minimumPrecipitation: json['minimumPrecipitation']?.toDouble(),
      optimalSoilWetness: json['optimalSoilWetness']?.toDouble(),
      harvestTime: json['harvestTime']?.toDouble()
    );
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
