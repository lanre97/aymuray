import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';

class VegetableState {
  final Vegetable? vegetable;
  final Location? location;
  final Map<String, dynamic>? bestMonths;
  final Map<String, dynamic>? bestSeasonsToSow;

  final bool isMonthly;
  final bool isSubmiting;
  final String? error;

  const VegetableState._(
      {this.vegetable,
      this.location,
      this.bestMonths,
      this.bestSeasonsToSow,
      this.error,
      required this.isMonthly,
      required this.isSubmiting});

  const VegetableState.submiting(
      {this.vegetable,
      this.location,
      this.bestMonths,
      this.bestSeasonsToSow,
      this.isMonthly = true})
      : isSubmiting = true,
        error = null;

  const VegetableState.error(String error, {this.vegetable, this.location})
      : bestMonths = null,
        bestSeasonsToSow = null,
        isSubmiting = false,
        this.error = error,
        isMonthly = true;

  const VegetableState.loaded(this.vegetable, this.location,
      {this.bestMonths, this.bestSeasonsToSow})
      : isSubmiting = false,
        error = null,
        isMonthly = true;

  VegetableState copyWith(
          {Vegetable? vegetable,
          Location? location,
          Map<String, dynamic>? climateQuality,
          Map<String, dynamic>? bestSeasonsToSow,
          bool? isSubmiting,
          String? error,
          bool? isMonthly}) =>
      VegetableState._(
          location: location ?? this.location,
          vegetable: vegetable ?? this.vegetable,
          bestMonths: climateQuality ?? this.bestMonths,
          bestSeasonsToSow: bestSeasonsToSow ?? this.bestSeasonsToSow,
          isSubmiting: isSubmiting ?? this.isSubmiting,
          error: error ?? this.error,
          isMonthly: isMonthly ?? this.isMonthly);
}
