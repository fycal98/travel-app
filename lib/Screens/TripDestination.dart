import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripDestination extends StatefulWidget {
  static const route = 'TripDestination';
  @override
  _TripDestinationState createState() => _TripDestinationState();
}

class _TripDestinationState extends State<TripDestination> {
  List trips = [];
  List<String> selectedcountries;
  Function remove(String country) {
    setState(() {
      selectedcountries.remove(country);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    List<String> c = data['selectedcountries'];
    selectedcountries = c;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    http
        .get(
            ('http://192.168.1.50:3000/trip?countries=${selectedcountries.join(',')},a'))
        .then((value) {
      trips = jsonDecode(value.body);
      setState(() {});
    });
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return Scaffold(
      endDrawer: RightDrawer(),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.black),
                expandedHeight: 130 * factor,
                elevation: 0,
                backgroundColor: Colors.greenAccent.withOpacity(0),
                flexibleSpace: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 40 * factor, left: 25 * factor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            data['region'],
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 30 * factor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10 * factor,
                        ),
                        Flexible(
                          child: Text(
                            'Ready to travel the world as a pro ? of course you are!\n'
                            'Our trip styles cater to pretty much to every one\n'
                            'So all you have to do is choose the style best sweets you',
                            style: TextStyle(
                                color: Colors.black45, fontSize: 8 * factor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floating: false,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    children: selectedcountries
                        .map((e) => CountryChip(
                              country: e,
                              remove: remove,
                            ))
                        .toList(),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Text(
                      'SORT BY DATE',
                      style: TextStyle(fontSize: 10, color: Colors.black45),
                    ),
                  ),
                ),
                ...trips.map((e) => TripCard()).toList()
              ]))
            ],
          ),
        ],
      ),
    );
  }
}

class CountryChip extends StatelessWidget {
  final String country;
  final Function remove;
  const CountryChip({this.country, this.remove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 4, bottom: 4, right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
                onPressed: () {
                  remove(country);
                },
              ),
              Text(
                country,
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  const TripCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: Offset(0.5, 0.5), // changes position of shadow
                    )
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sailing trip.jpg')),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TURKISH SAILING',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                      'from  ',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      '\$1,119.00',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'TURKEY TO TARZAN BAY\n'
                      '8 DAYS/1 COUNTRY',
                      style: TextStyle(fontSize: 8),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                        'START CITY, FETHIYE\n'
                        'END CITY, FETHIYE',
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.w500))
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow.shade600),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade600,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade600,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade600,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.yellow.shade600,
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
