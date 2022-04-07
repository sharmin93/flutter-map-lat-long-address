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
  GoogleMapController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: UdText(
            text: 'Map',
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: UdDesign.pt(400),
              child: Stack(
                children: [
                  GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition:
                          context.watch<MapController>().initCamera,
                      onMapCreated: (GoogleMapController controller) {
                        CameraUpdate? update = CameraUpdate.newCameraPosition(
                            context.watch<LocationController>().newPosition!);
                        controller.moveCamera(update);
                        _controller.complete(controller);
                      },
                      onCameraMove: (value) {
                        context.read<MapController>().onMove(value);
                      }),
                  const Center(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
            UdGapY(
              value: 10,
            ),
            //Latitude
            Padding(
              padding:
                  EdgeInsets.only(top: UdDesign.pt(10), left: UdDesign.pt(10)),
              child: Row(
                children: [
                  UdText(
                    text: 'Latitude:',
                  ),
                  UdGapX(
                    value: 10,
                  ),
                  UdText(
                    text: context.watch<MapController>().mapLat != null
                        ? ' ${context.watch<MapController>().mapLat}'
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
              padding: EdgeInsets.only(
                top: UdDesign.pt(10),
                left: UdDesign.pt(10),
              ),
              child: Row(
                children: [
                  UdText(
                    text: 'Longitude:',
                  ),
                  UdGapX(
                    value: 10,
                  ),
                  UdText(
                    text: context.watch<MapController>().mapLong != null
                        ? ' ${context.watch<MapController>().mapLong}'
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
              padding: EdgeInsets.only(
                top: UdDesign.pt(10),
                left: UdDesign.pt(10),
              ),
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
                    text: context.watch<MapController>().mapAddress != null
                        ? '${context.watch<MapController>().mapAddress}'
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
                  context.read<MapController>().updateLocation().then((value) {
                    if (value == true) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            )
          ],
        ));
  }
}
