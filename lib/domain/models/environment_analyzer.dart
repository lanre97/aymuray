import 'dart:math';

import 'package:space_farm/common/constants.dart';
import 'package:space_farm/data/entities/nasa_power_response.dart';
import 'package:space_farm/common/extensions.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'environment.dart';

class EnvironmentAnalyzer{
  List<Environment> environments;

  EnvironmentAnalyzer({required NasaPowerResponse response})
  :environments = _getEnvironments(response);

  static List<Environment>_getEnvironments(NasaPowerResponse response){

    final dates = response.data[NASAPowerParameters.TEMPERATURE_AT_2_METERS]?.keys.toList();

    if(dates == null){
      return <Environment>[];
    }

    return dates.map((e){
      final  dateTime = e.toDateTime(pattern: 'yyyyMM');
      return Environment(
        year: dateTime.year, 
        month: dateTime.month,
        luminescence: response.data[NASAPowerParameters.GLOBAL_ILLUMINANCE]?[e],
        temperatureAt2Meters: response.data[NASAPowerParameters.TEMPERATURE_AT_2_METERS]?[e],
        maxTemperatureAt2Meters: response.data[NASAPowerParameters.TEMPERATURE_AT_2_METERS_MAXIMUM]?[e],
        minTemperatureAt2Meters: response.data[NASAPowerParameters.TEMPERATURE_AT_2_METERS_MINIMUM]?[e],
        snowDeep: response.data[NASAPowerParameters.SNOW_DEPTH]?[e],
        windSpeed: response.data[NASAPowerParameters.WIND_SPEED_AT_2_METERS]?[e],
        soilWetness: response.data[NASAPowerParameters.ROOT_ZONE_SOIL_WETNESS]?[e]
      );
    }).toList();

  }

  getEnvironmentsInMonths(){
    final environments = [...this.environments]..removeWhere((element) => element.month! > 12);
    return environments.where((element) => element.year == environments.last.year);
  }

  getEnvironmentsInYears(){
    var currentYear = environments[0].year;
    final currentList = <Environment>[];
    final finalList = <Environment>[];

    for(int i = 0; i<environments.length; i++){
      final currentEnvironment = environments[i];
      if(currentEnvironment.year != currentYear){
        finalList.add(_getEnviromentAverage(currentList));
        currentList.clear();
        currentYear = currentEnvironment.year;
      }
      currentList.add(currentEnvironment);
    }

    return finalList;
  }

  List<Environment> predictOneYearEnviroments() {
    return List<int>.generate(12, (i) => i+1).map((month){
      return _getEnviromentAverage(environments.where((e) => e.month == month).toList());
    }).toList();
  }

  Environment _getEnviromentAverage(List<Environment> enviroments) {
    double luminescence = 0;
    double maxTemperatureAt2Meters = 0;
    double minTemperatureAt2Meters = 0;
    double precipitation = 0;
    double snowDeep = 0;
    double soilWetness = 0;
    double temperatureAt2Meters = 0;
    double windSpeed = 0;

    int length = enviroments.length;

    enviroments.forEach((element) {
      luminescence += element.luminescence ?? 0;
      maxTemperatureAt2Meters += element.maxTemperatureAt2Meters ?? 0;
      minTemperatureAt2Meters += element.minTemperatureAt2Meters ?? 0;
      precipitation += element.precipitation;
      snowDeep += element.snowDeep;
      soilWetness += element.soilWetness ?? 0;
      temperatureAt2Meters += element.temperatureAt2Meters ?? 0;
      windSpeed += element.windSpeed ?? 0;
    });

    return Environment(
      year: environments[0].year,
      luminescence: luminescence / length,
      temperatureAt2Meters: temperatureAt2Meters / length,
      maxTemperatureAt2Meters: maxTemperatureAt2Meters / length,
      minTemperatureAt2Meters: minTemperatureAt2Meters / length,
      precipitation: precipitation / length,
      snowDeep: snowDeep / length,
      soilWetness: soilWetness / length,
      windSpeed: windSpeed / length);
  }

  static double? _calculateTemperatureImportance(
    Environment env, VegetableEnvironment crop) {
    double? temperatureImportance;
    if (crop.canCalcTempImportance && env.canCalcTempImportance) {
      if (env.temperatureAt2Meters! >= crop.topTemperatureLimit! ||
          env.temperatureAt2Meters! <= crop.lowerTemperatureLimit!) {
        temperatureImportance = 0;
      } else if (env.temperatureAt2Meters! >= crop.optimalLowerTemperature! &&
          env.temperatureAt2Meters! <= crop.optimalTopTemperature!) {
        temperatureImportance = 1;
      } else if (env.temperatureAt2Meters! > crop.lowerTemperatureLimit! &&
          env.temperatureAt2Meters! < crop.optimalLowerTemperature!) {
        temperatureImportance =
            (env.temperatureAt2Meters! - crop.lowerTemperatureLimit!) /
                (crop.optimalLowerTemperature! - crop.lowerTemperatureLimit!);
      } else if (env.temperatureAt2Meters! > crop.topTemperatureLimit! &&
          env.temperatureAt2Meters! > crop.optimalTopTemperature!) {
        temperatureImportance =
            (crop.topTemperatureLimit! - env.temperatureAt2Meters!) /
                (crop.topTemperatureLimit! - crop.optimalTopTemperature!);
      }
    }

    return temperatureImportance;
  }

  static double? _calculateTemperatureVaritionImportance(
      Environment env, VegetableEnvironment crop) {
    double? temperatureVaritionImportance;

    if (env.canCalcTempVaritionImportance && crop.canCalcTempVaritionImportance) {
      double envVarition =
          env.maxTemperatureAt2Meters! - env.minTemperatureAt2Meters!;

      if (crop.temperatureVariation! < envVarition) {
        temperatureVaritionImportance = 0;
      } else {
        temperatureVaritionImportance =
            (crop.temperatureVariation! - envVarition) /
                crop.temperatureVariation!;
      }
    }
    return temperatureVaritionImportance;
  }

  static double _calculateTemperaturePenalty(Environment env, VegetableEnvironment crop) {
    double penalty = 1; // penalty goes from 0 to 1
    // 0 is high penalty and 1 is low
    double difference = 0;
    if (crop.canCalcTempPenalty && env.canCalcTempPenalty) {
      if (env.maxTemperatureAt2Meters! > crop.topTemperatureLimit!) {
        difference =
            (env.maxTemperatureAt2Meters! - crop.topTemperatureLimit!).abs();
      } else if (env.minTemperatureAt2Meters! < crop.lowerTemperatureLimit!) {
        difference = crop.lowerTemperatureLimit! - env.minTemperatureAt2Meters!;
      }
      if (difference > 20) {
        penalty = 0;
      } else {
        penalty = 1 - (difference / 20);
      }
    }

    return penalty;
  }

  static double? _calculateWindSpeedImportance(
      Environment env, VegetableEnvironment crop) {
    double? windSpeedImportance;

    if (env.canCalcWindSpeedImportance && crop.canCalcWindSpeedImportance) {
      if (env.windSpeed! >= crop.maximumWindSpeed!) {
        windSpeedImportance = 0;
      } else {
        windSpeedImportance =
            (crop.maximumWindSpeed! - env.windSpeed!) / crop.maximumWindSpeed!;
      }
    }
    return windSpeedImportance;
  }

  static double? _calculateLuminiscenceImportance(
      Environment env, VegetableEnvironment crop) {
    double? luminiscenceImportance;
    if (env.canCalcLuminicenceImportance && crop.canCalcLuminicenceImportance) {
      double distanceToCenter =
          (crop.maximumLuminosity! - crop.minimumLuminosity!) / 2;
      double center = distanceToCenter + crop.minimumLuminosity!;
      if (env.luminescence! > (crop.minimumLuminosity! - distanceToCenter) &&
          env.luminescence! < (crop.maximumLuminosity! + distanceToCenter)) {
        luminiscenceImportance =
            1 - ((center - env.luminescence!).abs() / (2 * distanceToCenter));
      } else {
        luminiscenceImportance = 0;
      }
    }

    return luminiscenceImportance;
  }

  static double? _calculateSoilWetnessImportance(
      Environment env, VegetableEnvironment crop) {
    double? soilWetnessImportance;

    if (env.canCalcSoilWetnessImportance && crop.canCalcSoilWetnessImportance) {
      if ((env.soilWetness! > crop.optimalSoilWetness! - 0.6) &&
          (env.soilWetness! < crop.optimalSoilWetness! + 0.6)) {
        soilWetnessImportance =
            1 - ((crop.optimalSoilWetness! - env.soilWetness!).abs() / 0.6);
      } else {
        soilWetnessImportance = 0;
      }
    }

    return soilWetnessImportance;
  }

  static double _calculateSnowDeepImportance(Environment env, VegetableEnvironment crop) {
    double snowDeepImportance;
    if (env.snowDeep < 0.2) {
      snowDeepImportance = 1;
    } else if (crop.maximumSnowDeep == 0 || env.snowDeep > crop.maximumSnowDeep!) {
      snowDeepImportance = 0;
    } else {
      snowDeepImportance =
          (crop.maximumSnowDeep! - env.snowDeep) / crop.maximumSnowDeep!;
    }

    return snowDeepImportance;
  }

  static double calculateSuccessProbability(Environment env, VegetableEnvironment crop) {
    double tempPenalty = _calculateTemperaturePenalty(env, crop);

    double temp = _calculateTemperatureImportance(env, crop) ?? 1;
    double tempVar = _calculateTemperatureVaritionImportance(env, crop) ?? 1;
    double wind = _calculateWindSpeedImportance(env, crop) ?? 1;
    double lum = _calculateLuminiscenceImportance(env, crop) ?? 1;
    double wet = _calculateSoilWetnessImportance(env, crop) ?? 1;
    double snow = _calculateSnowDeepImportance(env, crop);

    double globalTemp = (temp * 0.8 + tempVar * 0.2) * tempPenalty;

    return sqrt(snow) * sqrt(globalTemp) * sqrt(wind) * sqrt(lum) * sqrt(wet);
  }

}