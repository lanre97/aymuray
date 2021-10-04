import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/constants.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';
import 'package:space_farm/domain/blocs/vegetable/vegetable_bloc.dart';
import 'package:space_farm/domain/blocs/vegetable/vegetable_state.dart';
import 'package:space_farm/domain/interactors/vegetable/vegetable_interactor.dart';
import 'package:space_farm/presentation/widgets/atoq_buttons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VegetableScreen extends StatelessWidget {
  final Location location;
  final Vegetable vegetable;
  const VegetableScreen(
      {Key? key, required this.location, required this.vegetable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VegetableBloc _vegetableBloc;
    return BlocProvider<VegetableBloc>(
      create: (context) => VegetableBloc(
          interactor: VegetableInteractorImplementation(
              nasaPowerRespository: NASAPowerRepositoryImplementation()))
        ..initialize(vegetable, location),
      child: Scaffold(
        body: BlocBuilder<VegetableBloc, VegetableState>(
            builder: (context, state) {
          _vegetableBloc = context.read<VegetableBloc>();
          if (state.isSubmiting) {
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.vegetable?.name ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AtoqButtonProWidget(
                      isActive: state.isMonthly,
                      text: 'Annual',
                      onPressed: () {
                        _vegetableBloc
                            .updateBestSeasonToSow(StatisticsPeriod.yearly);
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  AtoqButtonProWidget(
                      isActive: !state.isMonthly,
                      text: 'Montly',
                      onPressed: () {
                        _vegetableBloc
                            .updateBestSeasonToSow(StatisticsPeriod.monthly);
                      }),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              chart(state.bestSeasonsToSow ?? {},
                  state.isMonthly ? 'Monthly' : 'Annual'),
              chart(state.bestMonths ?? {}, 'Prediction')
            ],
          );
        }),
      ),
    );
  }

  Widget chart(Map<String, dynamic> data, String title) {
    List<Map> _data = [];
    data.forEach((key, value) {
      _data.add({'key': key, 'value': value});
    });
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: title),
          series: <LineSeries>[
            LineSeries(
                // Bind data source
                dataSource: _data,
                xValueMapper: (env, _) => '${env['key']}',
                yValueMapper: (env, _) => env['value'])
          ]),
    );
  }
}
