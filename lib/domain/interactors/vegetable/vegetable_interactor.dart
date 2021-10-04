import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';
import 'package:space_farm/domain/models/environment.dart';
import 'package:space_farm/domain/models/environment_analyzer.dart';

abstract class VegetableInteractor {
  Future<Map<String, dynamic>> getBestSeasonToSow(Location location,
      VegetableEnvironment environment, StatisticsPeriod period);
  Future<Map<String, dynamic>> getBestMonths(
      Location location, VegetableEnvironment environment);
}

class VegetableInteractorImplementation implements VegetableInteractor {
  final NASAPowerRepository _nasaPowerRepository;
  EnvironmentAnalyzer? _analyzer;

  VegetableInteractorImplementation(
      {required NASAPowerRepository nasaPowerRespository})
      : _nasaPowerRepository = nasaPowerRespository;

  Future<List<Environment>> _getEnvironmentData(
      Location location, StatisticsPeriod period) async {
    if (_analyzer == null) {
      _analyzer = EnvironmentAnalyzer(
          response: await _nasaPowerRepository.getEnvironmentData(location));
    }
    if (period == StatisticsPeriod.monthly) {
      return _analyzer!.getEnvironmentsInMonths();
    }
    return _analyzer!.getEnvironmentsInYears();
  }

  @override
  Future<Map<String, dynamic>> getBestMonths(
      Location location, VegetableEnvironment environment) async {
    final analyzer = EnvironmentAnalyzer(
        response: await _nasaPowerRepository.getEnvironmentData(location));
    final data = analyzer.predictOneYearEnviroments();
    return Map.fromIterable(data,
        key: (env) => (env.month ?? 0).toString(),
        value: (env) =>
            EnvironmentAnalyzer.calculateSuccessProbability(env, environment));
  }

  @override
  Future<Map<String, dynamic>> getBestSeasonToSow(Location location,
      VegetableEnvironment environment, StatisticsPeriod period) async {
    var localEnvironment = await _getEnvironmentData(location, period);
    return Map.fromIterable(localEnvironment,
        key: (env) =>
            (period == StatisticsPeriod.monthly ? env.month : env.year)
                .toString(),
        value: (env) =>
            EnvironmentAnalyzer.calculateSuccessProbability(env, environment));
  }
}
