import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:space_farm/domain/blocs/home/home_bloc.dart';

class MapTypeButtonWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final MapType mapType;
  const MapTypeButtonWidget(
      {Key? key, required this.homeBloc, required this.mapType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: CircleBorder(),
      child: PopupMenuButton<String>(
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 10, 10),
            child: Icon(
              Icons.layers,
              color: Colors.grey[800],
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'normal',
                enabled: mapType != MapType.normal,
                child: TextButton.icon(
                    onPressed: () {
                      homeBloc.changeMapType(MapType.normal);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.map),
                    label: Text(
                      'Normal',
                    )),
              ),
              PopupMenuItem(
                value: 'satelite',
                enabled: mapType != MapType.satellite,
                child: TextButton.icon(
                    onPressed: () {
                      homeBloc.changeMapType(MapType.hybrid);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.satellite),
                    label: Text(
                      'Satelital',
                    )),
              ),
              PopupMenuItem(
                value: 'terrain',
                enabled: mapType != MapType.terrain,
                child: TextButton.icon(
                    onPressed: () {
                      homeBloc.changeMapType(MapType.terrain);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.terrain),
                    label: Text(
                      'Relieve',
                    )),
              )
            ];
          }),
    );
  }
}
