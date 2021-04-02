import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mytaxiclone/resources/brand_colors.dart';
import 'package:mytaxiclone/screens/homescreen.dart';
import 'package:mytaxiclone/screens/signupscreen.dart';
import 'package:mytaxiclone/services/Authentication.dart';
import 'package:mytaxiclone/widgets/RoundedButton.dart';
import 'package:mytaxiclone/widgets/TextField.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _password;
  String _email;
  final _auth = Auth();
  static const String id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
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
                    "Sign in as A rider",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Brand-Bold", fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          onClick: (value) {
                            _email = value;
                          },
                          hint: 'Email Address',
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
                          title: "LOGIN",
                          color: BrandColors.colorGreen,
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                connectivityResult != ConnectivityResult.wifi) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("No Internet Connection"),
                                ),
                              );
                            }
                            if (_globalKey.currentState.validate()) {
                              _globalKey.currentState.save();
                              try {
                                _auth.login(_email, _password);
                                Navigator.of(context).pushNamed(Home.id);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                  ),
                                );
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignupScreen.id);
                      },
                      child: Text("Don't Have an account, Sign up here")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
