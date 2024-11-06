import "package:geolocator/geolocator.dart";
import "package:healing_guide_flutter/exceptions/app_exception.dart";
import "package:latlong2/latlong.dart";

Future<LatLng> userLatLng() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    throw AppException.locationServiceDisabled;
  }

  var permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      throw AppException.locationPermissionDenied;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw AppException.locationPermissionDeniedPermanently;
  }

  final position = await Geolocator.getCurrentPosition();
  return LatLng(position.latitude, position.longitude);
}
