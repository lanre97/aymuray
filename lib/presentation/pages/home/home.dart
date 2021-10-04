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
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
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
                  Positioned(top: 150, right: 0, child: PlantPopUp()),
                  if (state.selectedLocation != null)
                    Positioned(
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AtoqButtonProWidget(
                              text: 'Information',
                              color: Colors.black,
                              borderColor: Colors.black,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return VegetableScreen(
                                      location: state.selectedLocation!,
                                      vegetable: examplePotato);
                                }));
                              }),
                        ],
                      ),
                    ),
                ],
              );
            },
          ));
    });
  }
}
