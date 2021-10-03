import 'package:space_farm/common/constants.dart';
import 'package:space_farm/data/entities/vegetable.dart';

abstract class VegetableInteractor{
  Future<Map<String, dynamic>> getClimateQuality(VegetableEnvironment environment, StatisticsPeriod period);
  Future<Map<String, dynamic>> getBestSeasonToSow(VegetableEnvironment environment, StatisticsPeriod period);
  Future<Map<String, dynamic>> getBestMonths(VegetableEnvironment environment, StatisticsPeriod period);
}