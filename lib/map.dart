import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {
  Geolocator geolocator = Geolocator();
  late List<LatLng> latlngs;
  late List<Marker> marks;
  final center = LatLng(43.9644879, -78.89896);
  String currentLocation = '';
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(zoom: 10.0, minZoom: 1, maxZoom: 18, center: center),
      layers: [
        TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/puggymunch/ckwpz9p6300km15nzlhppz8cm/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicHVnZ3ltdW5jaCIsImEiOiJja3dweW1sZWQwMzJwMndtdHBpb29vN29mIn0.jCFIhg3-aLy-QRA6W4rUSw',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoicHVnZ3ltdW5jaCIsImEiOiJja3dweW1sZWQwMzJwMndtdHBpb29vN29mIn0.jCFIhg3-aLy-QRA6W4rUSw',
              'id': 'mapbox.mapbox-streets-v8'
            }),
        MarkerLayerOptions(markers: [
          Marker(
              point: point,
              builder: (BuildContext) {
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  iconSize: 30.0,
                  color: Colors.blueAccent,
                );
              })
        ]),
      ],
    );
  }
}
