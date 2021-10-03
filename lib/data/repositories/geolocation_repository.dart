import 'package:geolocator/geolocator.dart';
import 'package:space_farm/common/utils.dart';
import 'package:location/location.dart' as location;

abstract class GeolocationRepository{
  Future<Location> getCurrentLocation();
}

class GeolocatitonRepositoryImplementation implements GeolocationRepository{

  @override
  Future<Location> getCurrentLocation() async{
    bool enabled = await Geolocator.isLocationServiceEnabled();
    Location? currentLocation;
    if (enabled) {
      await Geolocator.getCurrentPosition().then((Position pos) {
        currentLocation = Location(pos.latitude, pos.longitude);
      });
    } else {
      await location.Location().requestService().then((isActive) async {
        if (isActive) {
          await Geolocator.getCurrentPosition().then((Position pos) {
            currentLocation = Location(pos.latitude, pos.longitude);
          });
        }
      });
    }
    return Location(currentLocation!.latitude, currentLocation!.longitude);
  }
}

