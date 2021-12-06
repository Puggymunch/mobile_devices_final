/*
This map is centered at Ontario Tech University, and will display both a marker 
that shows the current location, which is assumed to be Ontario Tech, as well 
as the respective marker of the selected grocery store.
*/

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'grocery_stores.dart';

class Map extends StatelessWidget {
  Geolocator geolocator = Geolocator();
  final center = LatLng(
      43.94580054103049, -78.89677467631834); //coordinates for Ontario Tech
  static LatLng point = LatLng(0, 0);
  static String name = '';
  static String address = '';

  Map({Key? key}) : super(key: key);

  Map.make(LatLng coordinates, List<Placemark> placemark, String location) {
    point = coordinates;
    name = location;
    address =
        "Address: ${placemark.first.street},  ${placemark.first.postalCode}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Map", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
              icon: Icon(Icons.restaurant, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroceryStores()),
                );
              },
            )
          ],
        ),
        body: FlutterMap(
          options:
              MapOptions(zoom: 14.0, minZoom: 1, maxZoom: 18, center: center),
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
                  point: center,
                  builder: (BuildContext) {
                    return const Icon(
                      Icons.accessibility_sharp,
                      color: Colors.blueAccent,
                      size: 30,
                    );
                  }),
              Marker(
                  point: point,
                  builder: (BuildContext) {
                    return IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext) {
                              return bottomSheet();
                            });
                      },
                      icon: const Icon(Icons.location_on),
                      iconSize: 30.0,
                      color: Colors.blueAccent,
                    );
                  })
            ]),
          ],
        ));
  }

  static Future<List<Placemark>> getAddress(
      double latitude, double longitude) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    return placemark;
  }

  Widget bottomSheet() {
    //used class code from lecture 17 as reference
    return Column(
      children: [
        Container(
          height: 100,
          color: Colors.blueAccent,
          child: ListTile(
            title: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            subtitle: Text(
              address,
              style: const TextStyle(color: Colors.white70, fontSize: 14.0),
            ),
            trailing: const Icon(Icons.shopping_cart),
          ),
        ),
      ],
    );
  }
}
