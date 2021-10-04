import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/zone_details.dart';
import 'package:space_farm/data/repositories/geolocation_repository.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';
import 'package:space_farm/domain/models/environment.dart';
import 'package:space_farm/domain/models/environment_analyzer.dart';

abstract class ZoneDetailsInteractor{
  Future<ZoneDetails> getZone(Location location);
  Future<Map<String, dynamic>> getIlluminance(
    Location location, StatisticsPeriod period);
  Future<Map<String, dynamic>> getTemperature(
    Location location, StatisticsPeriod period);
  Future<Map<String, dynamic>> getSoilWetness(
    Location location, StatisticsPeriod period);
  Future<Map<String, dynamic>> getPrecipitations(
    Location location, StatisticsPeriod period);
  Future<Map<String, dynamic>> getWindSpeed(
    Location location, StatisticsPeriod period);
  
}

class ZoneDetailsInteractorImplementation implements ZoneDetailsInteractor{

  final NASAPowerRepository _nasaPowerRepository;
  final GeolocationRepository _geolocationRepository;
  EnvironmentAnalyzer? _analyzer;

  ZoneDetailsInteractorImplementation({
    required NASAPowerRepository nasaPowerRespository, 
    required GeolocationRepository geolocationRepository})
  :
  _nasaPowerRepository=nasaPowerRespository,
  _geolocationRepository = geolocationRepository;

  Future<List<Environment>> _getEnvironmentData(Location location, StatisticsPeriod period) async{
    if(_analyzer == null){
      _analyzer = EnvironmentAnalyzer(response: await _nasaPowerRepository.getEnvironmentData(location));
    }
    if(period == StatisticsPeriod.monthly){
      return _analyzer!.getEnvironmentsInMonths();
    }
    return _analyzer!.getEnvironmentsInYears();
  }

  @override
  Future<ZoneDetails> getZone(Location location) async{
    final address = await _geolocationRepository.getAddress(location);
    final environment = _analyzer!.predictOneYearEnviroments().firstWhere(
      (element) => element.month == DateTime.now().month);
    
    return ZoneDetails(name: address, description: "", environment: environment);

  }

  @override
  Future<Map<String, dynamic>> getIlluminance(Location location, StatisticsPeriod period) async{
    final environment = await _getEnvironmentData(location, period);
    return Map<String, Environment>.fromIterable(environment, 
      key: (env)=>(env.monthly).toString(),
      value: (env)=> env.luminescence
    );
  }

  @override
  Future<Map<String, dynamic>> getPrecipitations(Location location, StatisticsPeriod period) async{
    final environment = await _getEnvironmentData(location, period);
    return Map<String, Environment>.fromIterable(environment, 
      key: (env)=>(env.monthly).toString(),
      value: (env)=> env.precipitation
    );
  }

  @override
  Future<Map<String, dynamic>> getSoilWetness(Location location, StatisticsPeriod period) async{
    final environment = await _getEnvironmentData(location, period);
    return Map<String, Environment>.fromIterable(environment, 
      key: (env)=>(env.monthly).toString(),
      value: (env)=> env.soilWetness
    );
  }

  @override
  Future<Map<String, dynamic>> getTemperature(Location location, StatisticsPeriod period) async{
    final environment = await _getEnvironmentData(location, period);
    return Map<String, Environment>.fromIterable(environment, 
      key: (env)=>(env.monthly).toString(),
      value: (env)=> env.temperatureAt2Meters
    );
  }

  @override
  Future<Map<String, dynamic>> getWindSpeed(Location location, StatisticsPeriod period) async{
    final environment = await _getEnvironmentData(location, period);
    return Map<String, Environment>.fromIterable(environment, 
      key: (env)=>(env.monthly).toString(),
      value: (env)=> env.windSpeed
    );
  }

  

}