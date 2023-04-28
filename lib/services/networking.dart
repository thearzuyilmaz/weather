import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  NetworkHelper(this.url);

  final String url;


  Future getData() async {
    //Uri url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=woerden&aqi=yes');
    Uri myUrl = Uri.parse(url);
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200){

      String data = response.body; //data'yı çektik
      var decodedData = jsonDecode(data); // var for dynamic data

      return decodedData;

    } else {

      print(response.statusCode);
    }

  }

}