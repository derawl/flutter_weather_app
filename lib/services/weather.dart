import 'networking.dart';
import 'location.dart';

const apiKey = 'YOUR_OPEN_WEATHER_MAP_APIKEY';

class WeatherModel {

  Future<dynamic> getCityWeather(cityName) async{
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    var weatherData = await NetworkHelper(url).getCityWeatherData();
    return weatherData;

  }

  Future<dynamic> getWeatherData() async{
    LocationAPI location = LocationAPI();
    await location.getLocation();

    Networking netWorker = Networking(location.latitude, location.longitude, apiKey);
    var weatherData = await netWorker.getWeatherData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

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
