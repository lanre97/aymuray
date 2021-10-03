import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/data/interactors/vegetable/vegetable_interactor.dart';
import 'package:space_farm/domain/blocs/vegetable/vegetable_state.dart';
import 'package:space_farm/data/entities/vegetable.dart';

class VegetableBloc extends Cubit<VegetableState>{

  final VegetableInteractor interactor;

  VegetableBloc({required this.interactor}) : super(VegetableState.submiting());

  initialize(Vegetable vegetable)async{
    emit(VegetableState.submiting(vegetable: vegetable));
    try{
      final climateQuality = 
        await interactor.getClimateQuality(state.vegetable!.environment, StatisticsPeriod.yearly);
      final bestSeasonsToSow = 
        await interactor.getBestSeasonToSow(state.vegetable!.environment, StatisticsPeriod.yearly);
      final bestMonths = 
        await interactor.getBestMonths(state.vegetable!.environment, StatisticsPeriod.yearly);

      emit(VegetableState.loaded(
        state.vegetable, 
        climateQuality: climateQuality, 
        bestSeasonsToSow: bestSeasonsToSow, 
        bestMonths: bestMonths
      ));

    }catch(error){
      final errorMessage = (error as dynamic).message;
      emit(VegetableState.error(errorMessage, vegetable: state.vegetable));
    }
  }

  updateClimateQuality(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getClimateQuality(state.vegetable!.environment, period)
    .then((value) => state.copyWith(climateQuality: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }

  updateBestSeasonToSow(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getBestSeasonToSow(state.vegetable!.environment, period)
    .then((value) => state.copyWith(bestSeasonsToSow: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }

  updateBestMonths(StatisticsPeriod period){
    emit(state.copyWith(isSubmiting: true));
    interactor.getBestMonths(state.vegetable!.environment, period)
    .then((value) => state.copyWith(bestMonths: value, error: null))
    .catchError((error) => state.copyWith(error: error.message));
  }


}