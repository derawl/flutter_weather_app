import 'package:geolocator/geolocator.dart';

class LocationAPI{
  double? latitude;
  double? longitude;


  Future<void> getLocation() async{
    try{
      Position position = await Geolocator.getCurrentPosition(forceAndroidLocationManager: true,desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
    }catch(e){
      print(e);
    }

  }

}