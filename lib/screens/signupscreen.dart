import 'package:flutter/material.dart';
import 'package:mytaxiclone/resources/brand_colors.dart';
import 'package:mytaxiclone/screens/homescreen.dart';
import 'package:mytaxiclone/screens/loginscreen.dart';
import 'package:mytaxiclone/widgets/RoundedButton.dart';
import 'package:mytaxiclone/widgets/TextField.dart';
import 'package:mytaxiclone/services/Authentication.dart';
import 'package:connectivity/connectivity.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _name;
  String _password;
  String _email;
  String _phone;
  final _auth = Auth();

  static const String id = 'SignupScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Image(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      image: AssetImage("assets/images/logo.png")),
                  SizedBox(height: 40),
                  Text(
                    "Create A rider account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Brand-Bold", fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          onClick: (value) {
                            _name = value;
                          },
                          hint: 'Full Name',
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          onClick: (value) {
                            _email = value;
                          },
                          hint: 'Email Address',
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          onClick: (value) {
                            _phone = value;
                          },
                          hint: 'Phone',
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          onClick: (value) {
                            _password = value;
                          },
                          hint: 'Password',
                        ),
                        SizedBox(height: 40),
                        RoundedButton(
                            title: "SIGN UP",
                            color: BrandColors.colorGreen,
                            onPressed: () async {
                              //check net work
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult !=
                                      ConnectivityResult.mobile &&
                                  connectivityResult !=
                                      ConnectivityResult.wifi) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("No Internet Connection"),
                                  ),
                                );
                              }
                              if (_globalKey.currentState.validate()) {
                                _globalKey.currentState.save();
                                try {
                                  _auth.singup(
                                      _email, _password, _name, _phone);
                                  Navigator.of(context).pushNamed(Home.id);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                    ),
                                  );
                                }
                              }
                            }),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.id);
                      },
                      child: Text("Already have an account? Log in")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
