import 'package:space_farm/data/entities/zone_details.dart';

class ZoneDetailsState{
  final ZoneDetails? details;
  final Map<String, dynamic>? humidity;
  final Map<String, dynamic>? bestSeasonsToSow;

  final bool isSubmiting;
  final String? error;

  const ZoneDetailsState._({
    this.details, 
    this.humidity, 
    this.bestSeasonsToSow,
    this.error, 
    required this.isSubmiting});

  const ZoneDetailsState.submiting({
    this.details, 
    this.humidity, 
    this. bestSeasonsToSow}):
    isSubmiting = true,
    error = null;

  const ZoneDetailsState.error(String error,{this.details}):
    humidity = null,
    bestSeasonsToSow = null,
    isSubmiting = false,
    this.error = error;
  
  const ZoneDetailsState.loaded(
    this.details, {this.humidity,this.bestSeasonsToSow}):
    isSubmiting = false,
    error = null;

  ZoneDetailsState copyWith({
    ZoneDetails? details,
    Map<String, dynamic>? humidity,
    Map<String, dynamic>? bestSeasonsToSow,
    bool? isSubmiting,
    String? error
  })=> ZoneDetailsState._(
    details:details??this.details,
    humidity: humidity??this.humidity,
    bestSeasonsToSow: bestSeasonsToSow??this.bestSeasonsToSow,
    isSubmiting: isSubmiting??this.isSubmiting,
    error:error??this.error
  );

}