import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/common/utils.dart';
import 'package:space_farm/data/entities/vegetable.dart';
import 'package:space_farm/data/repositories/geolocation_repository.dart';
import 'package:space_farm/domain/blocs/home/home_bloc.dart';
import 'package:space_farm/domain/blocs/home/home_state.dart';
import 'package:space_farm/presentation/pages/statistics_page/statistics_page.dart';
import 'package:space_farm/presentation/widgets/atoq_buttons.dart';

import 'google_maps_widgets/map_type_button_widget.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({
    Key? key,
  }) : super(key: key);

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  GoogleMapController? _googleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    void _onMapCreated(GoogleMapController controller) {
      _googleMapController = controller;
      geolocationRepositoryImpl.moveToCurrentPosition(controller);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 5),
        child: AppBar(
          automaticallyImplyLeading: false,
        ),
      ),
      body: BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            final HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);

            List<Marker> markers = [];
            if (state.selectedLocation != null) {
              markers.add(Marker(
                markerId: MarkerId('cropMarker'),
                position: LatLng(state.selectedLocation!.latitude,
                    state.selectedLocation!.longitude),
              ));
            }
            //List<SafeZone> safeZones = [];
            return Stack(
              children: [
                GoogleMap(
                  //padding: EdgeInsets.only(top: 40),
                  initialCameraPosition:
                      GeolocationRepositoryImpl.initialCameraPosition,
                  onMapCreated: _onMapCreated,
                  mapType: state.mapType,
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
                    _homeBloc.changeLocation(
                        Location(latLng.latitude, latLng.longitude));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90, right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MapTypeButtonWidget(
                          homeBloc: _homeBloc, mapType: state.mapType),
                      if (state.selectedLocation != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AtoqButtonProWidget(
                                text: 'Info',
                                color: Colors.black,
                                borderColor: Colors.greenAccent,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StatisticsPage(
                                        latLng: LatLng(
                                            state.selectedLocation!.latitude,
                                            state.selectedLocation!.longitude),
                                        vegetable: examplePotato);
                                  }));
                                }),
                          ],
                        )
                    ],
                  ),
                )
              ],
            );
          })),
    );
  }
}
