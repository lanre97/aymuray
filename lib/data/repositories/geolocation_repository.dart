import 'package:space_farm/common/utils.dart';

abstract class GeolocationRepository{
  Future<Location> getCurrentLocation();
}