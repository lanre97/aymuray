import 'package:space_farm/common/utils.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

abstract class GeolocationRepository {
  Future<Location?> getCurrentLocation();
}

class GeolocationRepositoryImpl extends GeolocationRepository {
  loc.Location _location = loc.Location();

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(-12.072840, -77.079470), zoom: 15, tilt: 20);

  CameraPosition lastCameraPosition(LatLng latLng) => CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude), zoom: 17, tilt: 20);

  Future<Location?> getCurrentLocation() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    Location? currentLocation;
    if (enabled) {
      await Geolocator.getCurrentPosition().then((Position pos) {
        currentLocation = Location(pos.latitude, pos.longitude);
      });
    } else {
      await _location.requestService().then((isActive) async {
        if (isActive) {
          //simpleMapsBloc.isGPSactiveSink.add(null);
          await Geolocator.getCurrentPosition().then((Position pos) {
            currentLocation = Location(pos.latitude, pos.longitude);
          });
        }
      });
    }
    return currentLocation;
  }

  moveToCurrentPosition(GoogleMapController? controller) async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (enabled) {
      await Geolocator.getCurrentPosition().then((Position pos) {
        controller!.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(pos.latitude, pos.longitude), 17));
      });
    } else {
      await _location.requestService().then((isActive) async {
        if (isActive) {
          await Geolocator.getCurrentPosition().then((Position pos) {
            controller!.animateCamera(CameraUpdate.newLatLngZoom(
                LatLng(pos.latitude, pos.longitude), 17));
          });
        }
      });
    }
  }

  moveTo(LatLng pos, GoogleMapController? controller) {
    controller!.animateCamera(CameraUpdate.newLatLngZoom(pos, 17));
  }
}

GeolocationRepositoryImpl geolocationRepositoryImpl =
    GeolocationRepositoryImpl();
