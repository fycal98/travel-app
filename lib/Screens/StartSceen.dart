import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginSceen.dart';
import 'MainScreen.dart';
import '../Data.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  static const route = 'StartScreen';
  List userInfo;
  Future<List> getToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Provider.of<Data>(context, listen: false)
        .changeUserInfo(prefs.getStringList('userInfo'));
    return prefs.getStringList('userInfo');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getToken(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasError) return LoginScreen();
        if (snapshot.data == null) return LoginScreen();

        return MainScreen();
      },
    );
  }
}
