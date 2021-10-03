import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';

class HomeState{
  final Location? selectedLocation;
  final Vegetable? selectedVegetable;
  final List<Vegetable>? vegetables;

  final bool isSubmiting;
  final String? error;

  const HomeState.submiting({this.selectedLocation, this.selectedVegetable}):
    vegetables = null, 
    error = null,
    isSubmiting = true;

  const HomeState.onError(String error,{this.selectedLocation, this.selectedVegetable}):
    this.vegetables = null,
    this.error = error,
    isSubmiting = false;

  const HomeState.loaded({this.selectedLocation, this.selectedVegetable, required this.vegetables}):
    error = null,
    isSubmiting = false;

}