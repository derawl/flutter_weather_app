import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stub/services/weather.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  void getLoc() async {
    print('a');
    var weatherData = await WeatherModel().getWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(
          locationWeather: weatherData,
      );
    }));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeInOut(
          color: Colors.white,
          size: 100.0,
        ),
      ),

    );
  }
}
