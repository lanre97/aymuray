import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/nasa_power_response.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/data/entities/zone_details.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';

abstract class ZoneDetailsInteractor{
  Future<NasaPowerResponse> getEnvironmentData(Location location);
  Future<Map<String, dynamic>> getBestSeasonToSow(
    Location location, StatisticsPeriod period);
  Future<Map<String, dynamic>> getHumidity(
    Location location, StatisticsPeriod period);
  Future<ZoneDetails> getZone(Location location);
}

class ZoneDetailsInteractorImplementation implements ZoneDetailsInteractor{

  final NASAPowerRepository _nasaPowerRepository;

  const ZoneDetailsInteractorImplementation({required NASAPowerRepository nasaPowerRespository})
  :_nasaPowerRepository=nasaPowerRespository;

  @override
  Future<NasaPowerResponse> getEnvironmentData(Location location) {
    return _nasaPowerRepository.getEnvironmentData(location);
  }

  @override
  Future<ZoneDetails> getZone(Location location) {
    // TODO: implement getZone
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getBestSeasonToSow(Location location, StatisticsPeriod period) {
    // TODO: implement getBestSeasonToSow
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getHumidity(Location location, StatisticsPeriod period) {
    // TODO: implement getHumidity
    throw UnimplementedError();
  }

}