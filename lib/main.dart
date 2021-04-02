import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytaxiclone/providers/appdata.dart';
import 'package:mytaxiclone/screens/homescreen.dart';
import 'package:mytaxiclone/screens/loginscreen.dart';
import 'package:mytaxiclone/screens/searchscreen.dart';
import 'package:mytaxiclone/screens/signupscreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:297855924061:ios:c6de2b69b03a5be8',
            apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
            projectId: 'flutter-firebase-plugins',
            messagingSenderId: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:920087207533:android:7595b1a02012d41ce12964',
            apiKey: 'AIzaSyD_OU8yBhFzjdfOmeqglSNr0W0YV4bfYG0',
            messagingSenderId: '920087207533',
            projectId: 'mytaxi-682a5',
            databaseURL: 'https://mytaxi-682a5-default-rtdb.firebaseio.com',
          ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Brand-Regular"),
        initialRoute: Home.id,
        routes: {
          SignupScreen.id: (context) => SignupScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          Home.id: (context) => Home(),
          SearchScreen.id:(context) =>SearchScreen()
        },
      ),
    );
  }
}
