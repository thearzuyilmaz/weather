import 'package:flutter/material.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'city_screen.dart';



class LocationScreen extends StatefulWidget {

  // Diğer sayfadan buraya yönlendirirken o sayfadaki datayı input olarak alıyoruz.
  LocationScreen({this.locationWeather});
  final locationWeather; //loading screen'den gelecek bu veri

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  // Non-nullable instance field 'cityName' must be initialized.
  // Try adding an initializer expression, or a generative constructor
  // that initializes it, or mark it 'late'.
  dynamic weatherData;
  String? weatherCondition;
  late int temperature;
  String? cityName ;
  String? icon;
  String? weatherMessage;
  WeatherModel weatherModel = WeatherModel(); //returns the updated data



  @override

  void initState() {
    // TODO: implement initState
    weatherData = widget.locationWeather; // StatefulWidget ile bağlantılı olduğu için yapabildik
    updateUI(weatherData); // widget.locationWeather = inputData
    //print('mey data is ${widget.locationWeather}');
  }

  void updateUI(dynamic inputData) {

    // live data'ya göre kendini güncellesin diye koyduk
      setState(() {

        if (inputData == null){
          temperature = 0;
          cityName = '';
          icon = 'Error';
          weatherMessage = 'Unable to get the updated data';
          return;

        }
        weatherCondition = inputData['current']['condition']['text']; //import 'dart:convert' sayesinde geliyor;
        double temp = inputData['current']['temp_c']; //local variable temp
        temperature = temp.toInt();
        cityName = inputData['location']['name'];
        icon = inputData['current']['condition']['icon'];
        weatherMessage = weatherModel.getMessage(temperature);
      });

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      // Üstteki oka basınca da UI'ı güncel dataya göre güncelliyor
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {

                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print('My city: $typedName'); // kontrol için

                      if (typedName != null){
                        weatherData = await weatherModel.getSearchedCityWeatherData(typedName);
                        updateUI(weatherData);

                      }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    CachedNetworkImage(
                      imageUrl: 'https:$icon',
                      height: 200.00,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



