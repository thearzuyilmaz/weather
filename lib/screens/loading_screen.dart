import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/services/weather.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double? latitude;
  double? longitude;

  @override
  //Latitude & Longitude data is coming once
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {

    var weatherData= await WeatherModel().getLocationWeather();


    // LocationScreen sayfasına yönlendiriyoruz bu fonk çalıştıkça
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 100.00,
        ),
      ),
    );
  }
}