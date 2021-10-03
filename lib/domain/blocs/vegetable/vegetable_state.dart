import 'package:space_farm/data/entities/vegetable.dart';

class VegetableState{
  final Vegetable? vegetable;
  final Map<String, dynamic>? climateQuality;
  final Map<String, dynamic>? bestSeasonsToSow;
  final Map<String, dynamic>? bestMonths;

  final bool isSubmiting;
  final String? error;

  const VegetableState._({this.vegetable, this.climateQuality, this.bestSeasonsToSow, this.bestMonths, this.error, required this.isSubmiting});

  const VegetableState.submiting({
    this.vegetable, 
    this.climateQuality, 
    this. bestSeasonsToSow, 
    this.bestMonths}):
    isSubmiting = true,
    error = null;

  const VegetableState.error(String error,{this.vegetable}):
    climateQuality = null,
    bestSeasonsToSow = null,
    bestMonths = null,
    isSubmiting = false,
    this.error = error;
  
  const VegetableState.loaded(
    this.vegetable, {this.climateQuality,this.bestSeasonsToSow, this.bestMonths}):
    isSubmiting = false,
    error = null;

  VegetableState copyWith({
    Vegetable? vegetable,
    Map<String, dynamic>? climateQuality,
    Map<String, dynamic>? bestSeasonsToSow,
    Map<String, dynamic>? bestMonths,
    bool? isSubmiting,
    String? error
  })=> VegetableState._(
    vegetable:vegetable??this.vegetable,
    climateQuality: climateQuality??this.climateQuality,
    bestSeasonsToSow: bestSeasonsToSow??this.bestSeasonsToSow,
    bestMonths: bestMonths??this.bestMonths,
    isSubmiting: isSubmiting??this.isSubmiting,
    error:error??this.error
  );

}