import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import 'package:http/http.dart' as http;
import 'StartSceen.dart';
import 'SearchScreen.dart';
import '../Data.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const route = 'MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  Widget future;
  ScrollController cont;
  double c1 = 15;
  double c2 = 10;
  double c3 = 10;
  double c4 = 10;
  double sigma = 0;
  Function setblur() {
    setState(() {
      sigma = 5;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    future = FutureBuilder<http.Response>(
      future: http.get('http://192.168.1.50:3000/user/trips?limit=4',
          headers: {'Authorization': context.read<Data>().userInfo[0]}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Container();
        List<dynamic> trips = jsonDecode(snapshot.data.body);
        List<Widget> tripsWidgets = trips
            .map((e) => TripCard(
                  image: e['imageUrl'],
                  title: e['title'],
                  des: e['description'],
                ))
            .toList();

        return ListView(
            controller: cont,
            scrollDirection: Axis.horizontal,
            children: tripsWidgets);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cont = ScrollController();
    cont.addListener(() {
      if (cont.position.pixels < 180) {
        setState(() {
          c1 = 15;
          c2 = 10;
          c3 = 10;
          c4 = 10;
        });
      } else if (cont.position.pixels < 360) {
        setState(() {
          c1 = 10;
          c2 = 15;
          c3 = 10;
          c4 = 10;
        });
      } else if (cont.position.pixels < 500) {
        setState(() {
          c1 = 10;
          c2 = 10;
          c3 = 15;
          c4 = 10;
        });
      } else {
        setState(() {
          c1 = 10;
          c2 = 10;
          c3 = 10;
          c4 = 15;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;

    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      endDrawer: RightDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    TopDeck(),
                    button(
                      setsigma: setblur,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0 * factor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 13 * factor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2 * factor),
                        child: Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 8 * factor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height: 480,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/main.jpeg'), fit: BoxFit.cover)),
          ),
          Padding(
            padding: EdgeInsets.all(12.0 * factor),
            child: Text(
              'Latest Trips',
              style: TextStyle(
                  fontSize: 20 * factor,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54.withOpacity(0.7)),
            ),
          ),
          Container(
            height: 150 * factor,
            child: future,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5 * factor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(3.0 * factor),
                    child: Icon(
                      Icons.circle,
                      size: c1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0 * factor),
                    child: Icon(
                      Icons.circle,
                      size: c2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0 * factor),
                    child: Icon(
                      Icons.circle,
                      size: c3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0 * factor),
                    child: Icon(
                      Icons.circle,
                      size: c4,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopDeck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return Column(
      children: [
        SizedBox(
          height: 100 * factor,
        ),
        Center(
          child: Text(
            'Topdeck',
            style: TextStyle(
                fontFamily: 'Pacifico-Regular',
                fontSize: 35 * factor,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 40 * factor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30 * factor),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.white,
              width: 2 * factor,
            )),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8 * factor, left: 8 * factor),
                child: Text(
                  'ARE YOU READY TO BE A TOPDECKER ?',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13 * factor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0 * factor, top: 2.0 * factor),
                child: Text(
                  'SEARCH YOUR DESTINATION',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 9 * factor),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showDateRangePicker(
              builder: (context, widget) {
                return Theme(data: ThemeData.dark(), child: widget);
              },
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            ).then((value) => http
                .get(
                    'http://192.168.1.50:3000/trip?minDate=${value.start.toString()}&maxDate=${value.end.toString()}')
                .then((value) => Navigator.pushNamed(
                    context, SearchScreen.route,
                    arguments: jsonDecode(value.body))));
          },
          child: Padding(
            padding: EdgeInsets.all(8.0 * factor),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Padding(
                    padding: EdgeInsets.all(8.0 * factor),
                    child: Column(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.white,
                          size: 70 * factor,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0 * factor),
                          child: Text(
                            'SELECT THE DATE',
                            style: TextStyle(
                                color: Colors.white, fontSize: 8 * factor),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}

class button extends StatelessWidget {
  Function setsigma;
  button({this.setsigma});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            setsigma();
            Scaffold.of(context).openEndDrawer();
          },
          icon: Icon(
            Icons.dehaze,
            color: Colors.white,
            size: 30 * factor,
          ),
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  String image;
  String title;
  String des;
  TripCard({this.image, this.title, this.des});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return Padding(
      padding: EdgeInsets.all(8.0 * factor),
      child: Container(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  des,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage('$image')),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.5,
                blurRadius: 3,
                offset: Offset(0.5, 0.5), // changes position of shadow
              )
            ],
            color: Colors.greenAccent,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 150 * factor,
        width: 200 * factor,
      ),
    );
  }
}
