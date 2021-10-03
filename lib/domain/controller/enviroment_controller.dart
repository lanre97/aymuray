import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/nasa_power_response.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';
import 'package:space_farm/domain/models/enviroment.dart';

Future<List<Enviroment>> getAllMonthlyEnviromentsFromAPI(LatLng latLng) async {
  List<Enviroment> enviroments = [];
  List<String> ids = [];
  // ignore: non_constant_identifier_names
  List<double> GI = [];
  // ignore: non_constant_identifier_names
  List<double> T2 = [];
  // ignore: non_constant_identifier_names
  List<double> T2MAX = [];
  // ignore: non_constant_identifier_names
  List<double> T2MIN = [];
  // ignore: non_constant_identifier_names
  List<double> SD = [];
  // ignore: non_constant_identifier_names
  List<double> WS2 = [];
  // ignore: non_constant_identifier_names
  List<double> SSW = [];
  NasaPowerResponse response =
      await NASAPowerRepositoryImplementation().getData(
          [
        NASAPowerParameters.GLOBAL_ILLUMINANCE,
        NASAPowerParameters.TEMPERATURE_AT_2_METERS,
        NASAPowerParameters.TEMPERATURE_AT_2_METERS_MAXIMUM,
        NASAPowerParameters.TEMPERATURE_AT_2_METERS_MINIMUM,
        NASAPowerParameters.SNOW_DEPTH,
        NASAPowerParameters.WIND_SPEED_AT_2_METERS,
        NASAPowerParameters.ROOT_ZONE_SOIL_WETNESS
      ],
          NASAPowerCommunities.AGROCLIMATOLOGY,
          Location(latLng.latitude, latLng.longitude), //16% a 37%
          //tarapoto
          //Location(-6.500086, -76.385022),//42% a 62%
          //Lima
          //Location(-12.0463731, -77.042754), //37% a 40%
          //Sahara desert
          //Location(21.646434, 12.515648), //0% a 37%
          //atlantic ocean
          //Location(20.130489, -31.334381), //0%
          //puno
          //Location(-31.334381, -70.066563), // 0% a 19%
          //groelandia
          //Location(63.478237, -46.376149),//0%
          DateTime.now().subtract(Duration(days: 3650)),
          DateTime.now().subtract(Duration(days: 366)));
  response.data.forEach((key, value) {
    if (key == NASAPowerParameters.GLOBAL_ILLUMINANCE) {
      value.forEach((key, value) {
        GI.add(value);
      });
    } else if (key == NASAPowerParameters.TEMPERATURE_AT_2_METERS) {
      value.forEach((key, value) {
        T2.add(value);
        ids.add(key);
      });
    } else if (key == NASAPowerParameters.TEMPERATURE_AT_2_METERS_MAXIMUM) {
      value.forEach((key, value) {
        T2MAX.add(value);
      });
    } else if (key == NASAPowerParameters.TEMPERATURE_AT_2_METERS_MINIMUM) {
      value.forEach((key, value) {
        T2MIN.add(value);
      });
    } else if (key == NASAPowerParameters.SNOW_DEPTH) {
      value.forEach((key, value) {
        SD.add(value);
      });
    } else if (key == NASAPowerParameters.WIND_SPEED_AT_2_METERS) {
      value.forEach((key, value) {
        WS2.add(value);
      });
    } else if (key == NASAPowerParameters.ROOT_ZONE_SOIL_WETNESS) {
      value.forEach((key, value) {
        SSW.add(value);
      });
    }
  });
  for (int i = 0; i < T2.length; i++) {
    String year = ids[i].substring(0, 4);
    String month = ids[i].substring(4, 6);
    enviroments.add(Enviroment(
        year: year,
        month: month,
        luminescence: GI.length > i ? GI[i] : null,
        temperatureAt2Meters: T2.length > i ? T2[i] : null,
        maxTemperatureAt2Meters: T2MAX.length > i ? T2MAX[i] : null,
        minTemperatureAt2Meters: T2MIN.length > i ? T2MIN[i] : null,
        snowDeep: SD.length > i ? SD[i] : 0,
        windSpeed: WS2.length > i ? WS2[i] : null,
        soilWetness: SSW.length > i ? SSW[i] : null));
  }

  return enviroments;
}

List<Enviroment> extract1YearEnviromentsInMonths(List<Enviroment> enviroments) {
  List<Enviroment> oneYearEnviroments = [];
  List<Enviroment> allEnviroments = [];
  allEnviroments.addAll(enviroments);
  allEnviroments.reversed.forEach((element) {
    if (element.month != '13') {
      if (oneYearEnviroments.isEmpty) {
        oneYearEnviroments.add(element);
      } else {
        if (oneYearEnviroments[0].year == element.year &&
            oneYearEnviroments.length < 12) {
          oneYearEnviroments.add(element);
        }
      }
    }
  });

  return oneYearEnviroments.reversed.toList();
}

List<Enviroment> extract10YearsEnviromentsInYears(
    List<Enviroment> enviroments) {
  List<Enviroment> allEnviroments = [];
  allEnviroments.addAll(enviroments);

  List<Enviroment> tenYears = [];

  String currentYear = '';
  List<Enviroment> oneYear = [];
  allEnviroments.forEach((element) {
    if (currentYear == element.year) {
      oneYear.add(element);
    } else if (currentYear.isEmpty) {
      currentYear = element.year;
      oneYear.add(element);
    } else {
      currentYear = element.year;
      tenYears.add(getEnviromentAverage(oneYear));
      oneYear.clear();
      oneYear.add(element);
    }
  });

  return tenYears;
}

List<Enviroment> predictOneYearEnviroments(List<Enviroment> enviroments) {
  List<Enviroment> allEnviroments = [];
  allEnviroments.addAll(enviroments);

  List<Enviroment> oneYearPrediction = [];
  final List<String> months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  months.forEach((month) {
    List<Enviroment> allMonths = [];
    allEnviroments.forEach((element) {
      if (element.month == month) {
        allMonths.add(element);
      }
    });
    oneYearPrediction.add(getEnviromentAverage(allMonths,
        month: month, year: DateTime.now().year.toString()));
  });

  return oneYearPrediction;
}

Enviroment getEnviromentAverage(List<Enviroment> enviroments,
    {String? month, String? year}) {
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

  return Enviroment(
      year: year ?? enviroments[0].year,
      month: month ?? '00',
      luminescence: luminescence / length,
      temperatureAt2Meters: temperatureAt2Meters / length,
      maxTemperatureAt2Meters: maxTemperatureAt2Meters / length,
      minTemperatureAt2Meters: minTemperatureAt2Meters / length,
      precipitation: precipitation / length,
      snowDeep: snowDeep / length,
      soilWetness: soilWetness / length,
      windSpeed: windSpeed / length);
}
