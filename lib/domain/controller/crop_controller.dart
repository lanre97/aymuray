import 'dart:math';

import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/domain/models/enviroment.dart';

double? calculateTemperatureImportance(
    Enviroment env, VegetableEnvironment crop) {
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

double? calculateTemperatureVaritionImportance(
    Enviroment env, VegetableEnvironment crop) {
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

double calculateTemperaturePenalty(Enviroment env, VegetableEnvironment crop) {
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

double? calculateWindSpeedImportance(
    Enviroment env, VegetableEnvironment crop) {
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

double? calculateLuminiscenceImportance(
    Enviroment env, VegetableEnvironment crop) {
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

double? calculateSoilWetnessImportance(
    Enviroment env, VegetableEnvironment crop) {
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

double calculateSnowDeepImportance(Enviroment env, VegetableEnvironment crop) {
  double snowDeepImportance;
  if (env.snowDeep < 0.2) {
    snowDeepImportance = 1;
  } else if (crop.maximumSnowDeep == 0 || env.snowDeep > crop.maximumSnowDeep) {
    snowDeepImportance = 0;
  } else {
    snowDeepImportance =
        (crop.maximumSnowDeep - env.snowDeep) / crop.maximumSnowDeep;
  }

  return snowDeepImportance;
}

double calculateSuccessProbability(Enviroment env, VegetableEnvironment crop) {
  double tempPenalty = calculateTemperaturePenalty(env, crop);

  double temp = calculateTemperatureImportance(env, crop) ?? 1;
  double tempVar = calculateTemperatureVaritionImportance(env, crop) ?? 1;
  double wind = calculateWindSpeedImportance(env, crop) ?? 1;
  double lum = calculateLuminiscenceImportance(env, crop) ?? 1;
  double wet = calculateSoilWetnessImportance(env, crop) ?? 1;
  double snow = calculateSnowDeepImportance(env, crop);

  double globalTemp = (temp * 0.8 + tempVar * 0.2) * tempPenalty;

  return sqrt(snow) * sqrt(globalTemp) * sqrt(wind) * sqrt(lum) * sqrt(wet);
}
