import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends ChangeNotifier {
  String? message;
  String? error;
  double? lat;
  double? long;
  String? address;
  bool? serviceEnabled;
  LocationPermission? permission;
  Position? location;
  CameraPosition? newPosition;
  CameraUpdate? update;
  Future<LocationPermission?> checkPosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == null) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      location = await Geolocator.getCurrentPosition();
      if (location?.longitude != null && location?.latitude != null) {
        lat = location?.latitude;
        long = location?.longitude;
        newPosition = CameraPosition(target: LatLng(lat!, long!), zoom: 16);
        update = CameraUpdate.newCameraPosition(newPosition!);
        List<Placemark> placeMarks =
            await placemarkFromCoordinates(lat!, long!);
        address = placeMarks.first.name;
        if (kDebugMode) {
          print('address$address');
        }
      }
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {}
    notifyListeners();
    return permission;
  }

  openSet() {
    if (Platform.isIOS) {
      Geolocator.openAppSettings();
    } else {
      Geolocator.openLocationSettings();
    }
  }
}
