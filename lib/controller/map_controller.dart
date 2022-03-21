import 'package:flutter/foundation.dart';
import 'package:flutter_own_project/controller/location_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier {
  LatLng? updatedLocation;
  double? lat;
  double? long;
  String? address;
  LocationController locationController = LocationController();
  final CameraPosition initCamera = const CameraPosition(
    target: LatLng(23.8103, 90.4125),
    zoom: 14.47,
  );
  late final List<Marker> markers = <Marker>[];
  List<Marker> addMarker(double? lat, double? long) {
    lat = lat;
    long = long;
    if (kDebugMode) {
      print('lat$lat');
      print('long$long');
    }
    markers.add(
      const Marker(
          draggable: true,
          markerId: MarkerId('mapId'),
          position: LatLng(23.8103, 90.4125),
          icon: BitmapDescriptor.defaultMarker),
    );

    return markers;
  }

  updateAddress(location) async {
    if (location?.longitude != null && location?.latitude != null) {
      lat = location?.latitude;
      long = location?.longitude;
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat!, long!);
      address = placeMarks.first.name;
      if (kDebugMode) {
        print('address$address');
      }
    }
  }

  // updateMarker(latLong) {
  //   markers.clear();
  //   markers.add(
  //     Marker(markerId: const MarkerId('markerid'), position: latLong),
  //   );
  //   if (kDebugMode) {
  //     print('latlon$latLong');
  //   }
  //   if (latLong != null) {
  //     updatedLocation = latLong;
  //     if (updatedLocation?.latitude != null &&
  //         updatedLocation?.longitude != null) {
  //       lat = updatedLocation?.latitude;
  //       long = updatedLocation?.longitude;
  //       placemarkFromCoordinates(lat!, long!).then((value) {
  //         address = value.first.name;
  //       });
  //
  //       if (kDebugMode) {
  //         print('address$address');
  //       }
  //     }
  //   }
  //   notifyListeners();
  //   return latLong;
  // }

}
