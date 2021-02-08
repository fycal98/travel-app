import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItineraryDetailsScreen extends StatelessWidget {
  ItineraryDetailsScreen({this.data});
  final data;
  static const route = 'ItineraryDetailsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/1d/3f/43/1d3f4336e6d4d0b3bf9b1d42948db42c.jpg'))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'DAY 13.',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'INTERLAKEN, SWIZERLAND',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                      child: Container(
                        color: Colors.white70.withOpacity(0),
                        height: 300,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'INCLUDED DETAILS',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Wrap(
                                    children: [
                                      Deatail(
                                        icon: Icons.restaurant_menu,
                                        title: 'BREAKFAST',
                                      ),
                                      Deatail(
                                        icon: Icons.hotel_outlined,
                                        title: 'HOTEL',
                                      ),
                                      Deatail(
                                        icon: Icons.directions_bus,
                                        title: 'BUS',
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  'OPTIONAL EXTRAS',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Wrap(
                                    children: [
                                      EXTRA(
                                        title: 'PARAGIDING',
                                        url:
                                            'https://i.pinimg.com/564x/ec/e6/46/ece64648d97d8abfba2ed6c7a299f67b.jpg',
                                      ),
                                      EXTRA(
                                        url:
                                            'https://i.pinimg.com/564x/dd/89/1a/dd891a748be375e604f0b4381ef9f426.jpg',
                                        title: 'TREKKING',
                                      ),
                                      EXTRA(
                                        title: 'LEKRBAD',
                                        url:
                                            'https://i.pinimg.com/564x/ac/55/b3/ac55b307e6e12db97cdd19763e6942e5.jpg',
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SafeArea(
            child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white70,
            ),
          ),
        ))
      ]),
    );
  }
}

class EXTRA extends StatelessWidget {
  final String url;
  final String title;
  const EXTRA({Key key, this.title, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(url),
            radius: 30,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white70, fontSize: 10),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            '\$ 220',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class Deatail extends StatelessWidget {
  final IconData icon;
  final String title;
  const Deatail({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white70, fontSize: 10),
          )
        ],
      ),
    );
  }
}
