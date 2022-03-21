import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_project/controller/map_controller.dart';
import 'package:flutter_own_project/ui/map_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ud_widgets/ud_widgets.dart';

import 'controller/location_controller.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationController>(context);
    final mapProvider = Provider.of<MapController>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //latitude
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
                          ? '${mapProvider.updatedLocation?.latitude}'
                          : '',
                    ),
                  ],
                ),
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
                      text: mapProvider.updatedLocation?.longitude != null
                          ? '${mapProvider.updatedLocation?.longitude}'
                          : '',
                    ),
                  ],
                ),
              ),
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
                      text: mapProvider.address != null
                          ? '${mapProvider.address}'
                          : '',
                    ),
                  ],
                ),
              ),
              UdGapY(
                value: 10,
              ),
              UdBasicButton(
                title: 'Set location',
                onTap: () {
                  locationProvider.checkPosition().then(
                    (value) {
                      if (value == LocationPermission.whileInUse ||
                          value == LocationPermission.always) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MapScreen(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              UdGapY(
                value: 10,
              ),
              mapProvider.updatedLocation != null
                  ? UdBasicButton(
                      title: 'Clear data',
                      onTap: () {
                        mapProvider.updatedLocation;
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
