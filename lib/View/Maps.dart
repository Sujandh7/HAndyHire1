import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  String _currentLocation = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      
      // Extract city name from the Placemark's locality field
      Placemark placemark = placemarks[0];
      String cityName = placemark.locality ?? 'Unknown city';

      setState(() {
        _currentLocation = cityName;
      });
    } catch (e) {
      print(e);
      setState(() {
        _currentLocation = 'Unable to fetch location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Page'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              size: 35,
              color: Colors.blue,
            ),
            SizedBox(width: 8),
            Text(
              _currentLocation,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
