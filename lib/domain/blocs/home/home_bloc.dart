import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/domain/blocs/home/home_state.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/domain/interactors/home/home_interactor.dart';

class HomeBloc extends Cubit<HomeState>{

  final HomeInteractor interactor;

  HomeBloc({required this.interactor}) : super(HomeState.submiting(mapType: MapType.normal));

  setMapController(GoogleMapController controller){
    emit(state.copyWith(mapController: controller));
  }

  getVegetables(){
    interactor.getVegetables()
    .then((value){
      emit(state.copyWith(isSubmiting: false, vegetables: value, selectedVegetable: value.first));
    })
    .catchError((error){
      print(error);
      emit(HomeState.onError(error.toString()));
    });
  }

  changeVegetable(Vegetable vegetable){
    emit(state.copyWith(
      selectedLocation: state.selectedLocation,
      selectedVegetable: vegetable,
      vegetables: state.vegetables,
      mapController: state.mapController
    ));
  }

  changeLocation(Location location){
    emit(state.copyWith(
      vegetables: state.vegetables,
      selectedLocation: location,
      selectedVegetable: state.selectedVegetable,
      mapController: state.mapController,
      mapType: state.mapType ?? MapType.normal
    ));
  }

  moveToCurrentPosition() async {
    final controller = state.mapController;
    final currentPosition = await interactor.getCurrenLocation();

    controller!.
    animateCamera(CameraUpdate.newLatLngZoom(
      LatLng(currentPosition.latitude, currentPosition.latitude), 17));

  }

  moveTo(Location location) {
    final controller = state.mapController;
    controller!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(location.latitude, location.longitude), 17));
  }

  changeMapType(MapType mapType) {
    emit(state.copyWith(mapType: mapType));
  }

  getInitialCameraPosition(){
    return CameraPosition(
      target: LatLng(-9.755568349600692, -75.67805076058177), zoom: 1, tilt: 20);
  }

}