import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_project/ui/map_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ud_widgets/ud_widgets.dart';

import '../controller/location_controller.dart';
import '../controller/map_controller.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      text: context.watch<MapController>().mapLat != null
                          ? ' ${context.watch<MapController>().mapLat}'
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
                      text: context.watch<MapController>().mapLong != null
                          ? '${context.watch<MapController>().mapLong}'
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
                      text: context.watch<MapController>().mapAddress != null
                          ? '${context.watch<MapController>().mapAddress}'
                          : '',
                    ),
                  ],
                ),
              ),
              UdGapY(
                value: 20,
              ),
              UdBasicButton(
                title: 'Set location',
                onTap: () {
                  context
                      .read<LocationController>()
                      .checkLocationPermission()
                      .then(
                    (value) {
                      if (value == LocationPermission.whileInUse ||
                          value == LocationPermission.always) {
                        context.read<LocationController>().location != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MapScreen(),
                                ),
                              )
                            : UdText(
                                text:
                                    'Something went wrong, please check your internet.',
                              );
                      }
                      if (value == LocationPermission.deniedForever) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return UdAlertWidget(
                              title: 'Set Location Permission',
                              message:
                                  'PLease allow location permission from application setting to set location.',
                              button1Text: 'cancel',
                              button1Function: () {
                                Navigator.pop(context);
                              },
                              button2Text: 'ok',
                              button2Function: () {
                                context.read<LocationController>().openSet();
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
              UdGapY(
                value: 10,
              ),

              context.watch<MapController>().mapLat != null &&
                      context.watch<MapController>().mapLong != null &&
                      context.watch<MapController>().mapAddress != null
                  ? UdBasicButton(
                      title: 'Clear data',
                      onTap: () {
                        context.read<MapController>().clearData();
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
