import 'package:flutter/material.dart';
import '../Screens/MainScreen.dart';
import '../Screens/TripStyleScreen.dart';
import '../Screens/TripDestinationScreen.dart';
import '../Screens/StartSceen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data.dart';
import 'package:provider/provider.dart';

class RightDrawer extends StatefulWidget {
  @override
  _RightDrawerState createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;

    return Container(
      width: 280 * factor,
      decoration: BoxDecoration(
        color: Color(0xFF191B1A),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80 * factor,
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 35 * factor,
                backgroundImage: NetworkImage(
                    'http://192.168.1.50:3000/${context.read<Data>().userInfo[3]}'),
              ),
              Text(
                context.read<Data>().userInfo[2],
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                '@${context.read<Data>().userInfo[1].split('@')[0]}',
                style: TextStyle(color: Colors.grey, fontSize: 9 * factor),
              )
            ],
          ),
          SizedBox(
            height: 40 * factor,
          ),
          ListTile(
            onTap: ModalRoute.of(context).settings.name == MainScreen.route
                ? null
                : () {
                    Navigator.pushReplacementNamed(context, MainScreen.route);
                  },
            contentPadding: EdgeInsets.only(left: 30 * factor),
            selectedTileColor: Colors.grey.withOpacity(0.1),
            selected: ModalRoute.of(context).settings.name == MainScreen.route,
            leading: Icon(
              Icons.home_outlined,
              color: Colors.white.withOpacity(0.8),
            ),
            title: Text(
              'HOME',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ListTile(
            onTap: ModalRoute.of(context).settings.name == TripStyleScreen.route
                ? null
                : () {
                    Navigator.pushReplacementNamed(
                        context, TripStyleScreen.route);
                  },
            contentPadding: EdgeInsets.only(left: 30 * factor),
            selectedTileColor: Colors.grey.withOpacity(0.1),
            selected:
                ModalRoute.of(context).settings.name == TripStyleScreen.route,
            leading: Icon(
              Icons.flag_outlined,
              color: Colors.white.withOpacity(0.8),
            ),
            title: Text(
              'TRIP STYLE',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, TripDestinationScreen.route);
            },
            contentPadding: EdgeInsets.only(left: 30 * factor),
            selectedTileColor: Colors.grey.withOpacity(0.1),
            selected: ModalRoute.of(context).settings.name ==
                TripDestinationScreen.route,
            leading: Icon(
              Icons.location_on,
              color: Colors.white.withOpacity(0.8),
            ),
            title: Text(
              'DESTINATION',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ExpansionTile(
            childrenPadding: EdgeInsets.only(left: 50 * factor),
            children: [
              ListTile(
                leading: Icon(
                  Icons.chat,
                  color: Colors.white70,
                  size: 20 * factor,
                ),
                title: Text(
                  'CHATS',
                  style:
                      TextStyle(color: Colors.white70, fontSize: 10 * factor),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.recommend,
                  color: Colors.white70,
                  size: 20 * factor,
                ),
                title: Text(
                  'RECOMMENDATIONS',
                  style:
                      TextStyle(color: Colors.white70, fontSize: 10 * factor),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.star_border,
                  color: Colors.white70,
                  size: 20 * factor,
                ),
                title: Text(
                  'REVIEWS',
                  style:
                      TextStyle(color: Colors.white70, fontSize: 10 * factor),
                ),
              ),
            ],
            title: Text(
              'COMMUNITY',
              style: TextStyle(color: Colors.white70),
            ),
            tilePadding: EdgeInsets.only(left: 30 * factor),
            leading: Icon(
              Icons.people_alt_outlined,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30 * factor),
            selectedTileColor: Colors.grey.withOpacity(0.1),
            selected: false,
            leading: Icon(
              Icons.person_outline,
              color: Colors.white.withOpacity(0.8),
            ),
            title: Text(
              'MY ACCOUNT',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushReplacementNamed(context, StartScreen.route);
            },
            contentPadding: EdgeInsets.only(left: 30 * factor),
            selectedTileColor: Colors.grey.withOpacity(0.1),
            selected: false,
            leading: Icon(
              Icons.logout,
              color: Colors.white.withOpacity(0.8),
            ),
            title: Text(
              'LOG OUT',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(8.0 * factor),
                child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {}),
              ),
            ),
          )
        ],
      ),
    );
  }
}
