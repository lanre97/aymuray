import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:space_farm/common/utils.dart' as utils;
import 'package:location/location.dart' as geocoder;


abstract class GeolocationRepository{
  Future<utils.Location> getCurrentLocation();
  Future<String> getAddress(utils.Location location);
}

class GeolocatitonRepositoryImplementation implements GeolocationRepository{

  @override
  Future<utils.Location> getCurrentLocation() async{
    bool enabled = await Geolocator.isLocationServiceEnabled();
    utils.Location? currentLocation;
    if (enabled) {
      await Geolocator.getCurrentPosition().then((Position pos) {
        currentLocation = utils.Location(pos.latitude, pos.longitude);
      });
    } else {
      await geocoder.Location().requestService().then((isActive) async {
        if (isActive) {
          await Geolocator.getCurrentPosition().then((Position pos) {
            currentLocation = utils.Location(pos.latitude, pos.longitude);
          });
        }
      });
    }
    return utils.Location(currentLocation!.latitude, currentLocation!.longitude);
  }

  @override
  Future<String> getAddress(utils.Location location) async{
    final locationData = await placemarkFromCoordinates(location.latitude, location.longitude,localeIdentifier: 'es_ES');
    final placemark = locationData.first;
    return "${placemark.locality}, ${placemark.country}";  
  }
}

