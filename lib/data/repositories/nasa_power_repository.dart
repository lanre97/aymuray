import 'dart:convert';

import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/extensions.dart';
import 'package:space_farm/data/entities/nasa_power_response.dart';
import 'package:http/http.dart' as http;

abstract class NASAPowerRepository{
  Future<NasaPowerResponse> getData(
    String service,
    List<String> parameters, 
    String community, 
    Location location, 
    DateTime startDate, 
    DateTime endDate
  );
}

class NASAPowerRepositoryImplementation implements NASAPowerRepository{

  static const String _baseURL = 'https://power.larc.nasa.gov/api/temporal';

  @override
  Future<NasaPowerResponse> getData(
      String service, List<String> parameters, 
      String community, Location location, DateTime startDate, 
      DateTime endDate) async{
    
    final params = parameters.join(",");

    final url = 
      '$_baseURL/$service/point?parameters=$params&community=$community&longitude=${location.longitude}'
      '&latitude=${location.latitude}&start=${startDate.format('yyyyMMdd')}&end=${endDate.format('yyyyMMdd')}&format=JSON';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return NasaPowerResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception(["Something went wrong, verify your parameters and try again"]);

  }

}