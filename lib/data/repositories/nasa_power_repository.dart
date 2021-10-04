import 'dart:convert';

import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/extensions.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/nasa_power_response.dart';
import 'package:http/http.dart' as http;

abstract class NASAPowerRepository{
  Future<NasaPowerResponse> getEnvironmentData(Location location);
}

class NASAPowerRepositoryImplementation implements NASAPowerRepository{

  static const String _baseURL = 'https://power.larc.nasa.gov/api/temporal';

  Future<NasaPowerResponse> getData(
      List<String> parameters, 
      String community, Location location, DateTime startDate, 
      DateTime endDate) async{
    
    final params = parameters.join(",");

    final url = 
      '$_baseURL/${NASAPowerServices.MONTHLY}/point?parameters=$params&community=$community&longitude=${location.longitude}'
      '&latitude=${location.latitude}&start=${startDate.format('yyyy')}&end=${endDate.format('yyyy')}&format=JSON';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return NasaPowerResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception(["Something went wrong, verify your parameters and try again"]);

  }

  @override
  Future<NasaPowerResponse> getEnvironmentData(Location location) {
    return getData(
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
      Location(location.latitude, location.longitude), //16% a 37%
      DateTime.now().subtract(Duration(days: 3650)),
      DateTime.now().subtract(Duration(days: 366))
    );
  }
}