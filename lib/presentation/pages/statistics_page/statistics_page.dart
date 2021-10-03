import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/domain/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:space_farm/domain/blocs/statistics_bloc/statistics_state.dart';
import 'package:space_farm/domain/controller/crop_controller.dart';
import 'package:space_farm/domain/models/enviroment.dart';
import 'package:space_farm/presentation/widgets/atoq_buttons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatelessWidget {
  final Vegetable vegetable;
  final LatLng latLng;
  const StatisticsPage(
      {Key? key, required this.vegetable, required this.latLng})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatisticsBloc _statisticsBloc;
    return BlocProvider<StatisticsBloc>(
      create: (context) => StatisticsBloc()..initialize(latLng),
      child: Scaffold(
        body: BlocBuilder<StatisticsBloc, StatisticsState>(
            builder: (context, state) {
          _statisticsBloc = context.read<StatisticsBloc>();
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.error?.isNotEmpty ?? false) {
            return Center(
              child: Text(
                '${state.error}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  vegetable.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AtoqButtonProWidget(
                      isActive: state.showingMonthlyGrap,
                      text: 'Annual',
                      onPressed: () {
                        _statisticsBloc.changeGrapTemporalty(false);
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  AtoqButtonProWidget(
                      isActive: !state.showingMonthlyGrap,
                      text: 'Montly',
                      onPressed: () {
                        _statisticsBloc.changeGrapTemporalty(true);
                      }),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              if (state.showingMonthlyGrap)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(
                          text:
                              '${state.lastYearMonthlyEnviroments?.last.year} monthly result'),
                      series: <LineSeries<Enviroment, String>>[
                        LineSeries<Enviroment, String>(
                            // Bind data source
                            dataSource: state.lastYearMonthlyEnviroments ?? [],
                            xValueMapper: (Enviroment env, _) => '${env.month}',
                            yValueMapper: (Enviroment env, _) =>
                                calculateSuccessProbability(
                                    env, vegetable.environment))
                      ]),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Last years Annual result'),
                      series: <LineSeries<Enviroment, String>>[
                        LineSeries<Enviroment, String>(
                            // Bind data source
                            dataSource:
                                state.lastTenYearsAnnualEnviroments ?? [],
                            xValueMapper: (Enviroment env, _) => '${env.year}',
                            yValueMapper: (Enviroment env, _) =>
                                calculateSuccessProbability(
                                    env, vegetable.environment))
                      ]),
                ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(
                        text:
                            'Prediction ${state.currentYearMonthlyEnviroments?.last.year} monthly result'),
                    series: <LineSeries<Enviroment, String>>[
                      LineSeries<Enviroment, String>(
                          // Bind data source
                          dataSource: state.currentYearMonthlyEnviroments ?? [],
                          xValueMapper: (Enviroment env, _) => '${env.month}',
                          yValueMapper: (Enviroment env, _) =>
                              calculateSuccessProbability(
                                  env, vegetable.environment))
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(
                        text:
                            'Temperature ${state.lastYearMonthlyEnviroments?.last.year} monthly result'),
                    series: <LineSeries<Enviroment, String>>[
                      LineSeries<Enviroment, String>(
                          // Bind data source
                          dataSource: state.lastYearMonthlyEnviroments ?? [],
                          xValueMapper: (Enviroment env, _) => '${env.month}',
                          yValueMapper: (Enviroment env, _) =>
                              env.temperatureAt2Meters)
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(
                        text:
                            'luminiscence ${state.lastYearMonthlyEnviroments?.last.year} monthly result'),
                    series: <LineSeries<Enviroment, String>>[
                      LineSeries<Enviroment, String>(
                          // Bind data source
                          dataSource: state.lastYearMonthlyEnviroments ?? [],
                          xValueMapper: (Enviroment env, _) => '${env.month}',
                          yValueMapper: (Enviroment env, _) => env.luminescence)
                    ]),
              ),
            ],
          );
        }),
      ),
    );
  }
}
