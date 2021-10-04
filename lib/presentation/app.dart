import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_farm/data/repositories/geolocation_repository.dart';
import 'package:space_farm/data/repositories/nasa_power_repository.dart';
import 'package:space_farm/data/repositories/vegetable_repository.dart';
import 'package:space_farm/domain/blocs/home/home_bloc.dart';
import 'package:space_farm/domain/blocs/vegetable/vegetable_bloc.dart';
import 'package:space_farm/domain/blocs/zone_details/zone_details_bloc.dart';
import 'package:space_farm/domain/interactors/home/home_interactor.dart';
import 'package:space_farm/domain/interactors/vegetable/vegetable_interactor.dart';
import 'package:space_farm/domain/interactors/zone_details/zone_details_interactor.dart';
import 'package:space_farm/presentation/pages/vegetable/vegetable.dart';
import 'package:space_farm/presentation/pages/zone_details/zone_details.dart';

import 'pages/home/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>HomeBloc(interactor: HomeInteractorImplementation(
          geolocationRepository: GeolocatitonRepositoryImplementation(),
          vegetableRepository: VegetableRepositoryImplementation()
        ))),
        BlocProvider(create: (context)=>VegetableBloc(interactor: VegetableInteractorImplementation(
          nasaPowerRespository: NASAPowerRepositoryImplementation()
        ))),
        BlocProvider(create: (context)=>ZoneDetailsBloc(interactor: ZoneDetailsInteractorImplementation(
          nasaPowerRespository: NASAPowerRepositoryImplementation(),
          geolocationRepository: GeolocatitonRepositoryImplementation()
        )))
      ],
      child: MaterialApp(
        title: 'Aymuray',
        theme: ThemeData(
          primaryColor: Color(0xFF559584),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
