import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/domain/blocs/vegetable/vegetable_state.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/domain/interactors/vegetable/vegetable_interactor.dart';

class VegetableBloc extends Cubit<VegetableState> {
  final VegetableInteractor interactor;

  VegetableBloc({required this.interactor}) : super(VegetableState.submiting());

  initialize(Vegetable vegetable, Location location) async {
    emit(VegetableState.submiting(vegetable: vegetable, location: location));
    try {
      final bestMonths =
          await interactor.getBestMonths(location, vegetable.environment);
      final bestSeasonsToSow = await interactor.getBestSeasonToSow(
          location, vegetable.environment, StatisticsPeriod.yearly);

      emit(VegetableState.loaded(vegetable, location,
          bestMonths: bestMonths, bestSeasonsToSow: bestSeasonsToSow));
    } catch (error) {
      final errorMessage = (error as dynamic).message;
      emit(VegetableState.error(errorMessage, vegetable: state.vegetable));
    }
  }

  updateClimateQuality(StatisticsPeriod period) {
    emit(state.copyWith(isSubmiting: true));
    interactor
        .getBestMonths(state.location!, state.vegetable!.environment)
        .then((value) => state.copyWith(climateQuality: value, error: null))
        .catchError((error) => state.copyWith(error: error.message));
  }

  updateBestSeasonToSow(StatisticsPeriod period) {
    emit(state.copyWith(isSubmiting: true));
    interactor
        .getBestSeasonToSow(
            state.location!, state.vegetable!.environment, period)
        .then((value) => state.copyWith(
            bestSeasonsToSow: value,
            error: null,
            isMonthly: period == StatisticsPeriod.monthly))
        .catchError((error) => state.copyWith(error: error.message));
  }
}
