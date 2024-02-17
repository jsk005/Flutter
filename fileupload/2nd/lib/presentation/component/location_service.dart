import 'dart:io';

import 'package:exif/exif.dart';
import 'package:fileupload/domain/models/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  double _latitude = 0;
  double _longitude = 0;
  bool _isLocation = false;

  Future<Location> getImageLocationInfo(var imagePath) async {
    final metadata = await readExifFromBytes(File(imagePath).readAsBytesSync());
    if (metadata.containsKey('GPS GPSLatitude')) {
      //print("location enabled");
      _isLocation = true;
      Location position = await getExifLocationData(metadata);
      _latitude = position.latitude;
      _longitude = position.longitude;
    } else {
      _isLocation = false;
      //print("location disabled");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _latitude = position.latitude;
      _longitude = position.longitude;
    }
    return Location(
        latitude: _latitude, longitude: _longitude, isLocation: _isLocation);
  }

  Future<void> locationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  Future<Location> getExifLocationData(var data) async {
    if (data.containsKey('GPS GPSLongitude')) {
      final gpsLatitude = data['GPS GPSLatitude'];
      final latitudeSignal = data['GPS GPSLatitudeRef']!.printable;
      List latitudeRation = gpsLatitude!.values.toList();
      List latitudeValue = latitudeRation.map((item) {
        return (item.numerator.toDouble() / item.denominator.toDouble());
      }).toList();
      _latitude = latitudeValue[0] +
          (latitudeValue[1] / 60) +
          (latitudeValue[2] / 3600);
      if (latitudeSignal == 'S') _latitude = -_latitude;
      print('latitude ::: ${_latitude}');

      final gpsLongitude = data['GPS GPSLongitude'];
      final longitudeSignal = data['GPS GPSLongitude']!.printable;
      List longitudeRation = gpsLongitude!.values.toList();
      List longitudeValue = longitudeRation.map((item) {
        return (item.numerator.toDouble() / item.denominator.toDouble());
      }).toList();
      _longitude = longitudeValue[0] +
          (longitudeValue[1] / 60) +
          (longitudeValue[2] / 3600);
      if (longitudeSignal == 'W') _longitude = -_longitude;
      print('longitude ::: ${_longitude}');

      return Location(latitude: _latitude, longitude: _longitude);
    }
    return Location(latitude: _latitude, longitude: _longitude);
  }
}
