import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';

class HomeState{
  final Location? selectedLocation;
  final Vegetable? selectedVegetable;
  final List<Vegetable>? vegetables;
  final MapType? mapType;

  final bool? isSubmiting;
  final String? error;
  final GoogleMapController? mapController;

  const HomeState._({
    required this.isSubmiting,
    this.mapType,
    this.selectedLocation,
    this.selectedVegetable,
    this.vegetables,
    this.error,
    this.mapController
  });

  const HomeState.submiting({
    this.selectedLocation, 
    this.selectedVegetable, 
    this.mapController,
    this.mapType}):
    vegetables = null, 
    error = null,
    isSubmiting = true;

  const HomeState.onError(
    String error,{
    this.selectedLocation, 
    this.selectedVegetable,
    this.mapController,
    this.mapType}):
    this.vegetables = null,
    this.error = error,
    isSubmiting = false;

  const HomeState.loaded({
    this.selectedLocation, 
    this.selectedVegetable, 
    this.mapType,
    this.mapController,
    this.vegetables}):
    error = null,
    isSubmiting = false;

  HomeState copyWith({
      Location? selectedLocation,
      Vegetable? selectedVegetable,
      List<Vegetable>? vegetables,
      bool? isSubmiting,
      String? error,
      GoogleMapController? mapController,
      MapType? mapType})=>
    HomeState._(
      selectedLocation: selectedLocation??this.selectedLocation,
      selectedVegetable: selectedVegetable??this.selectedVegetable,
      vegetables: vegetables??this.vegetables,
      isSubmiting: isSubmiting??this.isSubmiting,
      error: error??this.error,
      mapController: mapController??this.mapController,
      mapType: mapType??this.mapType
    );
}