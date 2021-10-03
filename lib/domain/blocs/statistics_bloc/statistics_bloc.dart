import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/domain/blocs/statistics_bloc/statistics_state.dart';
import 'package:space_farm/domain/controller/enviroment_controller.dart';

class StatisticsBloc extends Cubit<StatisticsState> {
  StatisticsBloc() : super(StatisticsState.loading());

  initialize(LatLng location) async {
    try {
      //emit(state.update(isLoading: true));
      final allEnviroments = await getAllMonthlyEnviromentsFromAPI(location);

      final currentYearMonthlyEnviroments =
          predictOneYearEnviroments(allEnviroments);

      final lastTenYearsAnnualEnviroments =
          extract10YearsEnviromentsInYears(allEnviroments);

      final lastYearMonthlyEnviroments =
          extract1YearEnviromentsInMonths(allEnviroments);

      emit(state.update(
          //allMonthlyEnviroments: allEnviroments,
          currentYearMonthlyEnviroments: currentYearMonthlyEnviroments,
          lastTenYearsAnnualEnviroments: lastTenYearsAnnualEnviroments,
          lastYearMonthlyEnviroments: lastYearMonthlyEnviroments,
          isLoading: false));
    } catch (error) {
      final errorMessage = (error as dynamic).message;
      emit(state.update(error: errorMessage, isLoading: false));
    }
  }

  changeGrapTemporalty(bool showingMonthlyGrap) {
    emit(state.update(showingMonthlyGrap: showingMonthlyGrap));
  }
}
