import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  double? latitude;
  double? longitude;
  String? apiKey;
  String? decodedDataBlock;

  Networking(this.latitude, this.longitude, this.apiKey);

  Future<dynamic> getWeatherData() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=$longitude&appid=$apiKey&units=metric");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}

class NetworkHelper{
  var url;
  NetworkHelper(this.url);

  Future<dynamic> getCityWeatherData() async{
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}