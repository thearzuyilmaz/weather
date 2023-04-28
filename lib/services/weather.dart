import 'package:weather/services/networking.dart';



const apiKey = 'a83d599e58b54e68bad43738232604';
const weatherMapURL = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=woerden&aqi=yes';



class WeatherModel {

  // Weather data based on searched city
  Future<dynamic> getSearchedCityWeatherData(String cityName) async{

    NetworkHelper networkHelper = NetworkHelper('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityName&aqi=yes');
    var weatherData = await networkHelper.getData(); //await need futures not void methods
    return weatherData;

  }

  // Getting data method for Woerden of WeatherModel class
  Future<dynamic> getLocationWeather() async {

    NetworkHelper networkHelper = NetworkHelper(weatherMapURL);
    var weatherData = await networkHelper.getData(); //await need futures not void methods

    return weatherData;

  }

  // getMessage method of WeatherModel Class
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
