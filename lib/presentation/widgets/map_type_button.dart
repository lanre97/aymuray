import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTypeButtonWidget extends StatelessWidget {
  final MapType mapType;
  final VoidCallback? normalButtonPressed;
  final VoidCallback? sateliteButtonPressed;
  final VoidCallback? terrainButtonPressed;

  const MapTypeButtonWidget(
      {Key? key, 
      required this.mapType,
      this.normalButtonPressed, 
      this.sateliteButtonPressed, 
      this.terrainButtonPressed})
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
                child: TextButton.icon(
                    onPressed: normalButtonPressed,
                    icon: Icon(Icons.map),
                    label: Text(
                      'Normal',
                    )),
              ),
              PopupMenuItem(
                value: 'satelite',
                child: TextButton.icon(
                    onPressed: sateliteButtonPressed,
                    icon: Icon(Icons.satellite),
                    label: Text(
                      'Satelital',
                    )),
              ),
              PopupMenuItem(
                value: 'terrain',
                child: TextButton.icon(
                    onPressed: terrainButtonPressed,
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