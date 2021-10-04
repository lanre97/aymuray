import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/domain/blocs/home/home_bloc.dart';
import 'package:space_farm/domain/blocs/home/home_state.dart';
import 'package:space_farm/presentation/pages/vegetable/vegetable.dart';
import 'package:space_farm/presentation/widgets/atoq_buttons.dart';
import 'package:space_farm/presentation/widgets/map_type_button.dart';
import 'package:space_farm/presentation/widgets/plant_popup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.vegetables == null) {
        context.read<HomeBloc>().getVegetables();
      }
    }, builder: (context, state) {
      return Scaffold(
          floatingActionButton: MapTypeButtonWidget(
            mapType: state.mapType ?? MapType.normal,
            sateliteButtonPressed: () {
              context.read<HomeBloc>().changeMapType(MapType.satellite);
            },
            normalButtonPressed: () {
              context.read<HomeBloc>().changeMapType(MapType.normal);
            },
            terrainButtonPressed: () {
              context.read<HomeBloc>().changeMapType(MapType.terrain);
            },
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              List<Marker> markers = [];
              if (state.selectedLocation != null) {
                markers.add(Marker(
                  markerId: MarkerId('cropMarker'),
                  position: LatLng(state.selectedLocation!.latitude,
                      state.selectedLocation!.longitude),
                ));
              }
              return Stack(
                children: [
                  GoogleMap(
                    padding: EdgeInsets.only(top: 50.0),
                    initialCameraPosition:
                        context.read<HomeBloc>().getInitialCameraPosition(),
                    onMapCreated: context.read<HomeBloc>().setMapController,
                    mapType: state.mapType ?? MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: Set.of(markers),
                    //buildingsEnabled: true,
                    compassEnabled: true,
                    //indoorViewEnabled: true,
                    //rotateGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    mapToolbarEnabled: true,
                    onLongPress: (latLng) {
                      context.read<HomeBloc>().changeLocation(
                          Location(latLng.latitude, latLng.longitude));
                    },
                  ),
                  state.isSubmiting ?? false
                      ? Container(
                          alignment: Alignment.center,
                          color: Colors.grey.withAlpha(200),
                          child: CircularProgressIndicator(),
                        )
                      : Positioned(
                          top: 150,
                          right: 0,
                          child: PlantPopUp(
                            vegetables: state.vegetables!,
                            selected: state.selectedVegetable!,
                            onChange: (selected) {
                              context
                                  .read<HomeBloc>()
                                  .changeVegetable(selected);
                            },
                          )),
                  state.selectedLocation != null
                      ? Positioned(
                          bottom: 10,
                          left: 20,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VegetableScreen(
                                          location: state.selectedLocation!,
                                          vegetable:
                                              state.selectedVegetable!)));
                            },
                            label: Text(
                              "Evaluate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.black,
                          ))
                      : Container()
                ],
              );
            },
          ));
    });
  }
}
