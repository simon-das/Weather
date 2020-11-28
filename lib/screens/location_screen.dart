import 'package:flutter/material.dart';
import 'package:weather/services/weather_icon.dart';
import 'package:weather_icons/weather_icons.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp, feelsLike, humidity, pressure, status;
  String cityName, condition;
  double windSpeed, _height, _width;
  IconData weatherIcon;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(weatherData) {
    temp = weatherData['main']['temp'].round();
    status = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    condition = weatherData['weather'][0]['main'];
    feelsLike = weatherData['main']['feels_like'].round();
    humidity = weatherData['main']['humidity'];
    pressure = weatherData['main']['pressure'];
    windSpeed = weatherData['wind']['speed'];

    weatherIcon = WeatherIcon().getIcon(status);
  }

  Text text({String txt, double fontSize}) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8FB7F4).withOpacity(0.5),
        title: Center(
          child: text(txt: 'Weather', fontSize: 35),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            _height = constraints.maxHeight;
            _width = constraints.maxWidth;
            return Column(
              children: <Widget>[
                Container(
                  width: _width,
                  height: _height * 0.17,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        _height * 0.035, _height * 0.01, 0, 0),
                    child: text(txt: '$tempº', fontSize: _height * 0.166),
                  ),
                ),
                Container(
                  width: _width,
                  height: _height * 0.1,
                  margin: EdgeInsets.only(top: _height * 0.005),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        _height * 0.048, _height * 0.01, 0, 0),
                    child: text(txt: '$cityName', fontSize: _height * 0.05),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01),
                  padding: EdgeInsets.only(top: _height * 0.02),
                  width: _width,
                  height: _height * 0.23,
                  child: Icon(weatherIcon, size: _height * 0.14),
                ),
                Container(
                  width: _width,
                  height: _height * 0.08,
                  child: Center(
                    child: text(txt: condition, fontSize: _height * 0.075),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      _width * 0.02, _height * 0.035, _width * 0.02, 0),
                  width: _width,
                  height: _height * 0.35,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                    margin: EdgeInsets.fromLTRB(7, 14, 7, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF8FB7F4).withOpacity(0.5),
                    ),
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        double localHeight = constraints.maxHeight;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            text(
                                txt: 'Feels like: $feelsLikeº',
                                fontSize: localHeight * 0.21),
                            text(
                                txt: 'Humidity: $humidity',
                                fontSize: localHeight * 0.21),
                            text(
                                txt: 'Pressure: $pressure',
                                fontSize: localHeight * 0.21),
                            text(
                                txt: 'Wind speed: $windSpeed',
                                fontSize: localHeight * 0.21),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
