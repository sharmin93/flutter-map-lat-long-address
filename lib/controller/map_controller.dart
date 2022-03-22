import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_own_project/controller/location_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  double? mapLat;
  double? mapLong;
  String? mapAddress;
  CameraPosition? newPosition;
  CameraUpdate? update;
  final Completer<GoogleMapController> controller = Completer();
  LocationController locationController = LocationController();
  final CameraPosition initCamera = const CameraPosition(
    target: LatLng(23.8103, 90.4125),
    zoom: 14.47,
  );

  Future<bool> updateLocation() async {
    if (mapLat != null && mapLong != null) {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(mapLat!, mapLong!);
      mapAddress = placeMarks.first.name;
      if (kDebugMode) {
        print('MapAddress$mapAddress');
      }
    }
    locationController.lat = mapLat;
    locationController.long = mapLong;
    locationController.address = mapAddress;
    notifyListeners();
    return true;
  }

  onMove(CameraPosition value) {
    mapLat = value.target.latitude;
    mapLong = value.target.longitude;
    if (kDebugMode) {
      print('moveLatValue${value.target.latitude}');
      print('moveLongValue${value.target.longitude}');
      print('moveProviderLat${mapLat}');
      print('moveProviderLong${mapLong}');
    }
    notifyListeners();
  }

  clearData() {
    mapLat = null;
    mapLong = null;
    mapAddress = null;
    notifyListeners();
  }
}
