import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mytaxiclone/helpers/request_helper.dart';
import 'package:mytaxiclone/models/address_model.dart';
import 'package:mytaxiclone/providers/appdata.dart';
import 'package:provider/provider.dart';

class HelperMethods {
  static Future<String> findCordinateAddress(Position position, context ) async {
    String placeAddess = '';
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
       return placeAddess;  
     }
     String url ="https://api.opencagedata.com/geocode/v1/json?q=${position.latitude}+${position.longitude}&key=65723dcc91dd4dc4817a32ddeac97393";
     var response = await Api.getRequest(url);
     if(response !="failed"){
       placeAddess = response["results"][0]["formatted"];

       Address pickupAddress = Address();
       pickupAddress.longitude =position.longitude;
       pickupAddress.latitude = position.latitude;
       pickupAddress.placename = placeAddess;
       Provider.of<AppData>(context, listen: false).updatepickupAddress(pickupAddress);
     } 
    return placeAddess;
  }
}
