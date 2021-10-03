import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';
import 'package:space_farm/domain/models/environment.dart';
import 'package:space_farm/domain/models/environment_analyzer.dart';

abstract class VegetableInteractor{
  Future<Map<String, dynamic>> getClimateQuality(
    Location location, VegetableEnvironment environment, StatisticsPeriod period);
  Future<Map<String, dynamic>> getBestSeasonToSow(
    Location location, VegetableEnvironment environment, StatisticsPeriod period);
  Future<Map<String, dynamic>> getBestMonths(
    Location location, VegetableEnvironment environment, StatisticsPeriod period);
}

class VegetableInteractorImplementation implements VegetableInteractor{

  final NASAPowerRepository _nasaPowerRepository;

  const VegetableInteractorImplementation({required NASAPowerRepository nasaPowerRespository})
  :_nasaPowerRepository=nasaPowerRespository;

  Future<List<Environment>> _getEnvironmentData(Location location, StatisticsPeriod period) async{
    final analyzer = EnvironmentAnalyzer(response: await _nasaPowerRepository.getEnvironmentData(location));
    if(period == StatisticsPeriod.monthly){
      return analyzer.getEnvironmentsInMonths();
    }
    return analyzer.getEnvironmentsInYears();
  }

  @override
  Future<Map<String, dynamic>> getBestMonths(
      Location location, VegetableEnvironment environment, StatisticsPeriod period) async{
    // TODO: implement getBestMonths
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getBestSeasonToSow(
      Location location, VegetableEnvironment environment, StatisticsPeriod period) async{
    // TODO: implement getBestSeasonToSow
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getClimateQuality(
      Location location, VegetableEnvironment environment, StatisticsPeriod period) async{
    var localEnvironment = await _getEnvironmentData(location, period);
    return Map.fromIterable(localEnvironment, 
      key: (env)=>(period == StatisticsPeriod.monthly?env.month:env.year).toString(),
      value: (env)=>EnvironmentAnalyzer.calculateSuccessProbability(env, environment)
    );
  }

}