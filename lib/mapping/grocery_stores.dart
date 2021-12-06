// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/*
Page will show a few grocery stores in the area and clicking on them will 
display the map with a marker detailing the name, address, and postal code. The 
street name and postal code will be geolocated.
When the location icon is clicked, the map will display with a marker placed at
the location of the grocery store.
*/

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'map.dart' as map;

class GroceryStores extends StatelessWidget {
  const GroceryStores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Stores Near You"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 60,
                color: Colors.grey,
                child: ListTile(
                  title: Text(
                    "Shoppers Drug Mart",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      LatLng point =
                          LatLng(43.947240901260976, -78.8938164399094);
                      map.Map.make(
                          point,
                          await map.Map.getAddress(
                              point.latitude, point.longitude),
                          "Shoppers Drug Mart"); //the geolocation for names is inconsistent so it is hardcoded
                      Navigator.pushNamed(
                        context,
                        '/display_map',
                      );
                    },
                    icon: const Icon(Icons.location_on),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                color: Colors.grey,
                child: ListTile(
                  title: Text(
                    "Byrava Supermarket",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      LatLng point =
                          LatLng(43.93183771799701, -78.88409866000819);
                      map.Map.make(
                          point,
                          await map.Map.getAddress(
                              point.latitude, point.longitude),
                          "Byrava Supermarket");
                      Navigator.pushNamed(
                        context,
                        '/display_map',
                      );
                    },
                    icon: const Icon(Icons.location_on),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                color: Colors.grey,
                child: ListTile(
                  title: Text(
                    "FreshCo Simcoe & Winchester",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      LatLng point =
                          LatLng(43.964594661861845, -78.9060229055967);
                      map.Map.make(
                          point,
                          await map.Map.getAddress(
                              point.latitude, point.longitude),
                          "FreshCo Simcoe & Winchester");
                      Navigator.pushNamed(
                        context,
                        '/display_map',
                      );
                    },
                    icon: const Icon(Icons.location_on),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                color: Colors.grey,
                child: ListTile(
                  title: Text(
                    "Liz's No Frills",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      LatLng point =
                          LatLng(43.92570380625389, -78.87531037282187);
                      map.Map.make(
                          point,
                          await map.Map.getAddress(
                              point.latitude, point.longitude),
                          "Liz's No Frills");
                      Navigator.pushNamed(
                        context,
                        '/display_map',
                      );
                    },
                    icon: const Icon(Icons.location_on),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                color: Colors.grey,
                child: ListTile(
                  title: Text(
                    "Sobeys Oshawa",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      LatLng point =
                          LatLng(43.93792445376523, -78.8590875176448);
                      map.Map.make(
                          point,
                          await map.Map.getAddress(
                              point.latitude, point.longitude),
                          "Sobeys Oshawa");
                      Navigator.pushNamed(
                        context,
                        '/display_map',
                      );
                    },
                    icon: const Icon(Icons.location_on),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
