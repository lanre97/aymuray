import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';

class HomeState {
  final Location? selectedLocation;
  final Vegetable? selectedVegetable;
  final List<Vegetable>? vegetables;
  final MapType mapType;

  final bool isSubmiting;
  final String? error;

  const HomeState.submiting(
      {this.selectedLocation,
      this.selectedVegetable,
      this.mapType = MapType.normal})
      : vegetables = null,
        error = null,
        isSubmiting = true;

  const HomeState.onError(String error,
      {this.selectedLocation,
      this.selectedVegetable,
      this.mapType = MapType.normal})
      : this.vegetables = null,
        this.error = error,
        isSubmiting = false;

  const HomeState.loaded(
      {this.selectedLocation,
      this.selectedVegetable,
      required this.vegetables,
      this.mapType = MapType.normal})
      : error = null,
        isSubmiting = false;

  HomeState copyWith({
    Location? selectedLocation,
    Vegetable? selectedVegetable,
    MapType? mapType,
  }) {
    return HomeState.submiting(
        selectedLocation: selectedLocation ?? this.selectedLocation,
        selectedVegetable: selectedVegetable ?? this.selectedVegetable,
        mapType: mapType ?? this.mapType);
  }

  HomeState update(
      {Location? selectedLocation,
    Vegetable? selectedVegetable,
    MapType? mapType,}) {
    return copyWith(
        selectedLocation: selectedLocation,
        selectedVegetable: selectedVegetable,
        mapType: mapType);
  }
}
