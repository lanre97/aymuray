import 'package:space_farm/domain/models/enviroment.dart';

class StatisticsState {
  final List<Enviroment>? allMonthlyEnviroments;
  final List<Enviroment>? lastYearMonthlyEnviroments;
  final List<Enviroment>? lastTenYearsAnnualEnviroments;
  final List<Enviroment>? currentYearMonthlyEnviroments;

  final bool isLoading;
  final String? error;
  final bool showingMonthlyGrap;

  const StatisticsState(
      {this.allMonthlyEnviroments,
      this.lastYearMonthlyEnviroments,
      this.lastTenYearsAnnualEnviroments,
      this.currentYearMonthlyEnviroments,
      this.error,
      required this.isLoading,
      required this.showingMonthlyGrap});

  factory StatisticsState.loading() {
    return StatisticsState(
        isLoading: true,
        allMonthlyEnviroments: [],
        currentYearMonthlyEnviroments: [],
        lastTenYearsAnnualEnviroments: [],
        lastYearMonthlyEnviroments: [],
        showingMonthlyGrap: true);
  }

  StatisticsState update(
          {List<Enviroment>? allMonthlyEnviroments,
          List<Enviroment>? lastYearMonthlyEnviroments,
          List<Enviroment>? lastTenYearsAnnualEnviroments,
          List<Enviroment>? currentYearMonthlyEnviroments,
          bool? isLoading,
          String? error,
          bool? showingMonthlyGrap}) =>
      StatisticsState(
          isLoading: isLoading ?? this.isLoading,
          allMonthlyEnviroments:
              allMonthlyEnviroments ?? this.allMonthlyEnviroments,
          lastYearMonthlyEnviroments: lastYearMonthlyEnviroments ??
              this.lastYearMonthlyEnviroments,
          lastTenYearsAnnualEnviroments: lastTenYearsAnnualEnviroments ??
              this.lastTenYearsAnnualEnviroments,
          currentYearMonthlyEnviroments: currentYearMonthlyEnviroments ??
              this.currentYearMonthlyEnviroments,
          showingMonthlyGrap: showingMonthlyGrap ?? this.showingMonthlyGrap);
}
