
import 'package:flutter/foundation.dart';
import 'package:mytaxiclone/models/address_model.dart';

class AppData extends ChangeNotifier{

  Address pickupAddress;

  void updatepickupAddress(Address address){
    pickupAddress= address;
    notifyListeners();
  } 
} 