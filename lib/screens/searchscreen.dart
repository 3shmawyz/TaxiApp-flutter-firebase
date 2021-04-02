
import 'package:flutter/material.dart';
import 'package:mytaxiclone/providers/appdata.dart';
import 'package:mytaxiclone/resources/brand_colors.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static String id = "SearchScreen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var pickupController = TextEditingController();
  var destinationContoller = TextEditingController();

  // putting crouser on where to goo ? better UX
  var focusOnDestination = FocusNode();

  bool focused = false;
  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusOnDestination);
      focused = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //call set focus
    setFocus();
    String address =
        Provider.of<AppData>(context).pickupAddress.placename ?? " ";
    pickupController.text = address;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .29,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 0.5,
                  offset: Offset(.7, .7))
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 48, left: 24, bottom: 24, right: 24),
              child: Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios)),
                      Center(
                          child: Text(
                        "Set Destination",
                        style:
                            TextStyle(fontSize: 20, fontFamily: "Brand-Bold"),
                      ))
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Image.asset("assets/images/pickicon.png",
                          height: 16, width: 16),
                      SizedBox(width: 18),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              controller: pickupController,
                              decoration: InputDecoration(
                                hintText: "Pick up Location",
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: null,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Image.asset("assets/images/desticon.png",
                          height: 16, width: 16),
                      SizedBox(width: 18),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              focusNode: focusOnDestination,
                              controller: destinationContoller,
                              decoration: InputDecoration(
                                hintText: "Where to ?",
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: null,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
