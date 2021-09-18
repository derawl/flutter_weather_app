import 'package:flutter/material.dart';
import 'package:stub/screens/city_screen.dart';
import 'package:stub/utilities/constants.dart';
import 'package:stub/services/weather.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temperature;
  String? city;
  String? weatherIcon;
  String? message;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(var weatherData){
    setState(() {
     if (weatherData == null){
       temperature = 0;
       city = '';
       weatherIcon = 'Error';
       message = 'Unable to get weather data';
       return;
     }
     var temp = weatherData['main']['temp'];
     temperature = temp.toInt();
     city = weatherData['name'];
     var condition = weatherData['weather'][0]['id'];
     weatherIcon = weatherModel.getWeatherIcon(condition!);
     message = weatherModel.getMessage(temperature!);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ops.jpg'),
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
                    onPressed: () {
                      var weatherData = weatherModel.getWeatherData();
                      if(weatherData != null){
                        updateUi(weatherData);
                      }

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if (typedName != null){
                        var weatherData = await weatherModel.getCityWeather(typedName);
                        updateUi(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.grey,
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
                    Text(
                      '$weatherIcon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0X80000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$message in $city",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
