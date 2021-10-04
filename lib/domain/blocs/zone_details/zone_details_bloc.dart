import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/domain/blocs/zone_details/zone_details_state.dart';
import 'package:space_farm/domain/interactors/zone_details/zone_details_interactor.dart';

class ZoneDetailsBloc extends Cubit<ZoneDetailsState>{

  final ZoneDetailsInteractor interactor;

  ZoneDetailsBloc({required this.interactor}) : super(ZoneDetailsState.submiting());

  initialize(Location location)async{
    try{
      final details =
        await interactor.getZone(location);
      final illuminance = await interactor.getIlluminance(location, StatisticsPeriod.monthly);
      final temperature = await interactor.getTemperature(location, StatisticsPeriod.monthly);
      final soilWetness = await interactor.getSoilWetness(location, StatisticsPeriod.monthly);
      final windSpeed = await interactor.getWindSpeed(location, StatisticsPeriod.monthly);
      final precipitation = await interactor.getPrecipitations(location, StatisticsPeriod.monthly);
      emit(ZoneDetailsState.loaded(
        details,
        location,
        illuminance: illuminance,
        temperature: temperature,
        soilWetness: soilWetness,
        windSpeed: windSpeed,
        precipitations: precipitation
      ));

    }catch(error){
      final errorMessage = (error as dynamic).message;
      emit(ZoneDetailsState.error(errorMessage));
    }
  }

  updateIlluminance(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getIlluminance(state.location!, period)
    .then((value) => state.copyWith(illuminance: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }

  updateTemperature(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getTemperature(state.location!, period)
    .then((value) => state.copyWith(temperature: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }

  updateSoilWetness(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getSoilWetness(state.location!, period)
    .then((value) => state.copyWith(soilWetness: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }
  
  updateWindSpeed(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getWindSpeed(state.location!, period)
    .then((value) => state.copyWith(windSpeed: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }

  updatePrecipitations(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getPrecipitations(state.location!, period)
    .then((value) => state.copyWith(precipitations: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }
  
}