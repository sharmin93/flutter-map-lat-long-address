import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../reusable/enums.dart';

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
  DataState dataState = DataState.initial;

  getCurrentAddress() async {
    dataState = DataState.initial;
    location = await Geolocator.getCurrentPosition();
    if (location != null) {
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
        dataState = DataState.loaded;
      } else {
        dataState = DataState.empty;
      }
    } else {
      dataState = DataState.error;
    }
    notifyListeners();
  }

  Future<LocationPermission?> checkLocationPermission() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        getCurrentAddress();
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

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
