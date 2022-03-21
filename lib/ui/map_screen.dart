import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_project/controller/location_controller.dart';
import 'package:flutter_own_project/controller/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? location;
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationController>(context);
    final mapProvider = Provider.of<MapController>(context);

    return Scaffold(
      appBar: AppBar(
        title: UdText(
          text: 'Map',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: UdDesign.pt(400),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: mapProvider.initCamera,
              markers: Set<Marker>.of(mapProvider.addMarker(
                  locationProvider.location?.latitude,
                  locationProvider.location?.longitude)),
              onMapCreated: (GoogleMapController controller) {
                CameraUpdate? update = CameraUpdate.newCameraPosition(
                    locationProvider.newPosition!);
                controller.moveCamera(update);
                _controller.complete(controller);
              },
            ),
          ),
          UdGapY(
            value: 8,
          ),
          //Latitude
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                UdText(
                  text: 'Latitude:',
                ),
                UdGapX(
                  value: 10,
                ),
                UdText(
                  text: mapProvider.updatedLocation?.latitude != null
                      ? ' ${mapProvider.updatedLocation?.latitude}'
                      : '',
                ),
              ],
            ),
          ),
          UdGapY(
            value: 8,
          ),
          //longitude
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                UdText(
                  text: 'Longitude:',
                ),
                UdGapX(
                  value: 10,
                ),
                UdText(
                  text: locationProvider.lat != null
                      ? ' ${locationProvider.lat}'
                      : '',
                ),
              ],
            ),
          ),
          UdGapY(
            value: 8,
          ),
          //address
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                UdText(
                  text: 'Address:',
                ),
                UdGapX(
                  value: 10,
                ),
                UdText(
                  maxLines: 2,
                  text: mapProvider.address != null
                      ? '${mapProvider.address}'
                      : '',
                ),
              ],
            ),
          ),
          UdGapY(
            value: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: UdBasicButton(
              width: UdDesign.pt(150),
              backgroundColor: Colors.blue,
              titleColor: Colors.white,
              title: 'Custom Address',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
