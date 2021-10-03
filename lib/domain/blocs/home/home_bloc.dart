import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/interactors/home/home_interactor.dart';
import 'package:space_farm/domain/blocs/home/home_state.dart';
import 'package:space_farm/data/entities/vegetable.dart';

class HomeBloc extends Cubit<HomeState> {
  final HomeInteractor? interactor;

  HomeBloc({this.interactor}) : super(HomeState.submiting());

  getVegetables() {
    interactor!
        .getVegetables()
        .then((value) => emit(HomeState.loaded(vegetables: value)))
        .catchError((error) => emit(HomeState.onError(error.message)));
  }

  changeVegetable(Vegetable vegetable) {
    emit(HomeState.loaded(
        selectedLocation: state.selectedLocation,
        selectedVegetable: vegetable,
        vegetables: state.vegetables));
  }

  changeLocation(Location location) {
    emit(state.update(selectedLocation: location));
    /*emit(HomeState.loaded(
        vegetables: state.vegetables,
        selectedLocation: location,
        selectedVegetable: state.selectedVegetable));*/
  }

  changeMapType(MapType mapType) {
    emit(state.update(mapType: mapType));
  }
}
