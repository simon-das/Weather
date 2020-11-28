import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIcon {
  IconData getIcon(int status) {
    if (status > 800) {
      return WeatherIcons.cloudy;
    } else if (status == 800) {
      return WeatherIcons.day_sunny;
    } else if (status == 701) {
      return WeatherIcons.fog;
    } else if (status == 711) {
      return WeatherIcons.smoke;
    } else if (status == 721) {
      return WeatherIcons.day_haze;
    } else if (status == 731) {
      return WeatherIcons.dust;
    } else if (status == 741) {
      return WeatherIcons.fog;
    } else if (status == 751) {
      return WeatherIcons.sandstorm;
    } else if (status == 761) {
      return WeatherIcons.dust;
    } else if (status == 762) {
      return WeatherIcons.dust;
    } else if (status == 771) {
      return WeatherIcons.cloudy_windy;
    } else if (status == 781) {
      return WeatherIcons.tornado;
    } else if (status > 600) {
      return WeatherIcons.snow;
    } else if (status > 500) {
      return WeatherIcons.rain;
    } else if (status > 300) {
      return WeatherIcons.raindrops;
    } else {
      return WeatherIcons.thunderstorm;
    }
  }
}
