import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/zone_details.dart';

abstract class ZoneDetailsInteractor{
  Future<ZoneDetails> getZone(Location location);
  Future<Map<String, dynamic>> getHumidity(Location location, StatisticsPeriod period);
  Future<Map<String, dynamic>> getBestSeasonToSow(Location location, StatisticsPeriod period);
}