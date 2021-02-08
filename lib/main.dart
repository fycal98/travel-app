import 'package:flutter/material.dart';
import 'package:topdeck/Screens/StartSceen.dart';
import 'Screens/LoginSceen.dart';
import 'Screens/MainScreen.dart';
import 'package:flutter/services.dart';
import 'Screens/TripStyleScreen.dart';
import 'Screens/TripStyle.dart';
import 'Screens/TripDestinationScreen.dart';
import 'Screens/TripDestination.dart';
import 'Screens/TripScreen.dart';
import 'Screens/ItenirerayDestailsScreen.dart';
import 'Screens/BookingScreen.dart';
import 'Screens/ProfileScreen.dart';
import 'Screens/SearchScreen.dart';
import 'Data.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        initialRoute: StartScreen.route,
        routes: {
          SearchScreen.route: (context) => SearchScreen(),
          StartScreen.route: (context) => StartScreen(),
          LoginScreen.route: (context) => LoginScreen(),
          MainScreen.route: (context) => MainScreen(),
          TripStyleScreen.route: (context) => TripStyleScreen(),
          TripStyle.route: (context) => TripStyle(),
          TripDestination.route: (context) => TripDestination(),
          TripDestinationScreen.route: (context) => TripDestinationScreen(),
          TripScreen.route: (context) => TripScreen(),
          ItineraryDetailsScreen.route: (context) => ItineraryDetailsScreen(),
          BookingScreen.route: (context) => BookingScreen(),
          ProfileScreen.route: (context) => ProfileScreen(),
        },
      ),
    );
  }
}
