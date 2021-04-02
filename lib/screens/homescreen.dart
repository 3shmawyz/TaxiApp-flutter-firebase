import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mytaxiclone/helpers/helper_methods.dart';
import 'package:mytaxiclone/providers/appdata.dart';
import 'package:mytaxiclone/resources/brand_colors.dart';
import 'package:mytaxiclone/resources/styles.dart';
import 'package:mytaxiclone/screens/searchscreen.dart';
import 'package:mytaxiclone/widgets/divider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  //MAP CONTRLLOER
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;
  //GEO LOCATOR
  Position currentPosition;

  void setupPositionLocator() async {
    //getlocation 1
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    //pass it in varibale 2
    currentPosition = position;
    // convert to X  Y   3
    LatLng xy = LatLng(position.latitude, position.longitude);
    //create new Camera  4
    CameraPosition cameraPosition = CameraPosition(target: xy, zoom: 14);
    //update the Camera 5
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await HelperMethods.findCordinateAddress(position,context);
    print(address);
  }

  //INTIAL MAP LOCATION
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.021544, 31.209882),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        drawer: Container(
          color: Colors.white,
          child: Drawer(
            child: ListView(
              children: [
                Container(
                  color: Colors.white,
                  height: 160,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/user_icon.png",
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "Brand-Bold"),
                            ),
                            SizedBox(height: 5),
                            Text("View Profile"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                MyDivider(),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.card_giftcard_outlined),
                  title: Text("Free Rides", style: KDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(Icons.payment_outlined),
                  title: Text("Payment", style: KDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Ride History", style: KDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(Icons.contact_support_outlined),
                  title: Text("Support", style: KDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text("about", style: KDrawerItemStyle),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: mapBottomPadding,top: 35),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,

              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
                setState(() {
                  mapBottomPadding = MediaQuery.of(context).size.height * .35;
                });
                setupPositionLocator();
              },
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  scaffoldkey.currentState.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7)),
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 14,
                          offset: Offset(.7, .7))
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        "Nice to see you",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Where are you going",
                        style:
                            TextStyle(fontSize: 18, fontFamily: "Brand-Bold"),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SearchScreen.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 0.5,
                                    offset: Offset(.7, .7))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 10),
                                Text("Search Destination"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Row(
                        children: [
                          Icon(Icons.home_outlined,
                              color: BrandColors.colorDimText),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Work"),
                              SizedBox(height: 3),
                              Text(
                                "Your Resdential address",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: BrandColors.colorDimText),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      MyDivider(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.work_outline_outlined,
                              color: BrandColors.colorDimText),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add home"),
                              SizedBox(height: 3),
                              Text(
                                "Your Office address",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: BrandColors.colorDimText),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
