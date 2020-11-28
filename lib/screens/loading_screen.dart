import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/services/network.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '31cd6860abe25ca600d775561db64446';
const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
//  checking location service and permission
    checkLocationService();
    checkLocationPermission();

//  getting current location
    try {
      _locationData = await location.getLocation();
    } catch (e) {
      print(e);
    }

//  fetching current weather data
    NetworkHelper networkHelper = NetworkHelper(
        '$weatherApiUrl?lat=${_locationData.latitude}&lon=${_locationData.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getWeatherData();

//  pushing to location screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherData,
      );
    }));
  }

  void checkLocationService() async {
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  void checkLocationPermission() async {
    PermissionStatus _permissionGranted;

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100,
      ),
    );
  }
}
