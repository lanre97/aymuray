import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/zone_details.dart';

class ZoneDetailsState{
  final ZoneDetails? details;
  final Location? location;
  final Map<String, dynamic>? illuminance;
  final Map<String, dynamic>? temperature;
  final Map<String, dynamic>? soilWetness;
  final Map<String, dynamic>? precipitations;
  final Map<String, dynamic>? windSpeed;


  final bool isSubmiting;
  final String? error;

  const ZoneDetailsState._({
    this.details, 
    this.location,
    this.illuminance,
    this.temperature,
    this.soilWetness,
    this.precipitations,
    this.windSpeed,
    this.error, 
    required this.isSubmiting});

  const ZoneDetailsState.submiting({
    this.details, 
    this.location,
    this.illuminance,
    this.temperature,
    this.soilWetness,
    this.precipitations,
    this.windSpeed}):
    isSubmiting = true,
    error = null;

  const ZoneDetailsState.error(String error,{this.details, this.location}):
    illuminance = null,
    temperature = null,
    soilWetness = null,
    precipitations = null,
    windSpeed = null,
    isSubmiting = false,
    this.error = error;
  
  const ZoneDetailsState.loaded(
    this.details,
    this.location, 
    {this.illuminance,
    this.temperature,
    this.soilWetness,
    this.precipitations,
    this.windSpeed}):
    isSubmiting = false,
    error = null;

  ZoneDetailsState copyWith({
    ZoneDetails? details,
    Map<String, dynamic>? illuminance,
    Map<String, dynamic>? temperature,
    Map<String, dynamic>? soilWetness,
    Map<String, dynamic>? precipitations,
    Map<String, dynamic>? windSpeed,
    bool? isSubmiting,
    String? error,
    Location? location,
  }) => ZoneDetailsState._(
    details:details??this.details,
    location: location??this.location,
    illuminance: illuminance??this.illuminance,
    temperature: temperature??this.temperature,
    soilWetness: soilWetness??this.soilWetness,
    precipitations: precipitations??this.precipitations,
    windSpeed: windSpeed??this.windSpeed,
    isSubmiting: isSubmiting??this.isSubmiting,
    error:error??this.error
  );

}