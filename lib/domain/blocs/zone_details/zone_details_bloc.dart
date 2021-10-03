import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/interactors/zone_details/zone_details_interactor.dart';
import 'package:space_farm/domain/blocs/zone_details/zone_details_state.dart';

class ZoneDetailsBloc extends Cubit<ZoneDetailsState>{

  final ZoneDetailsInteractor interactor;

  ZoneDetailsBloc({required this.interactor}) : super(ZoneDetailsState.submiting());

  initialize(Location location)async{
    try{
      final details =
        await interactor.getZone(location);
      final humidity = 
        await interactor.getHumidity(location, StatisticsPeriod.yearly);
      final bestSeasonsToSow = 
        await interactor.getBestSeasonToSow(location, StatisticsPeriod.yearly);

      emit(ZoneDetailsState.loaded(
        details,
        humidity: humidity, 
        bestSeasonsToSow: bestSeasonsToSow
      ));

    }catch(error){
      final errorMessage = (error as dynamic).message;
      emit(ZoneDetailsState.error(errorMessage));
    }
  }

  updateHumidity(Location location, StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getHumidity(location, period)
    .then((value) => state.copyWith(humidity: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }

  updateBestSeasonToSow(Location location, StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getBestSeasonToSow(location, period)
    .then((value) => state.copyWith(bestSeasonsToSow: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }

}