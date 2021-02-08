import 'dart:ui';

import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import 'TripStyle.dart';
import '../Widgets/CountriesBottomSheet.dart';

class TripDestinationScreen extends StatelessWidget {
  static const route = 'TripDestinationScreen';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return Scaffold(
      endDrawer: RightDrawer(),
      backgroundColor: Color(0xFFF6F6F6),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 130 * factor,
                elevation: 0,
                backgroundColor: Colors.greenAccent.withOpacity(0),
                flexibleSpace: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(
                      20 * factor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            'DESTINATION',
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
                  StyleGrid(
                    image: 'europe.jpg',
                    title: 'EUROPE',
                    countries: europe,
                  ),
                  StyleGrid(
                    image: 'alaska.jpg',
                    countries: namerica,
                    title: 'NORTH AMERICA',
                  ),
                  StyleGrid(
                    image: 'asia.jpg',
                    countries: asia,
                    title: 'ASIA',
                  ),
                  StyleGrid(
                    image: 'australi.jpg',
                    countries: australia,
                    title: 'AUSTRALIA &\n'
                        'NEW ZELAND',
                  ),
                  StyleGrid(
                    image: 'africa.jpg',
                    countries: africa,
                    title: 'AFRICA',
                  ),
                  StyleGrid(
                    countries: nafrica,
                    image: 'algeria.jpg',
                    title: 'MIDDLE EAST &\n'
                        'NORTH AFRICA',
                  ),
                ]),
              ),
            ],
          ),
          DrawerButton()
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return SafeArea(
      child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.dehaze,
              size: 30 * factor,
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          )),
    );
  }
}

class StyleGrid extends StatelessWidget {
  final String image;
  final String title;
  final List<String> countries;

  const StyleGrid({this.image, this.title, this.countries});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return Padding(
      padding: EdgeInsets.only(top: 3.0 * factor),
      child: Container(
        height: 350 * factor,
        width: double.infinity,
        child: GridTile(
          footer: Container(
            height: 100 * factor,
            child: Stack(
              children: [
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.greenAccent.withOpacity(0),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0 * factor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20 * factor,
                                  fontWeight: FontWeight.w600),
                            ),
                            // Text(text,
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 7 * factor,
                            //     ))
                          ],
                        ),
                        OutlinedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 25 * factor,
                                      vertical: 18 * factor),
                                ),
                                side: MaterialStateProperty.all(
                                    BorderSide(width: 1, color: Colors.white)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))))),
                            onPressed: () {
                              showBottomSheet(
                                  backgroundColor: Colors.black.withOpacity(0),
                                  context: context,
                                  builder: (widget) {
                                    return CountriesSheet(
                                      countries: countries,
                                      region: title,
                                    );
                                  });
                            },
                            child: Text(
                              'SELECT COUNTRIES',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12 * factor),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/$image'))),
          ),
        ),
      ),
    );
  }
}

List<String> europe = [
  'Belgium',
  'Cyprus,'
      'Estonia',
  'Finland',
  'France',
  'Germany',
  'Greece',
  'Ireland',
  'Italy',
  'Latvia',
  'Lithuania',
  'Luxembourg',
  'Malta',
  'Netherlands',
  'Portugal',
  'Spain',
  'Slovenia',
  'Slovakia',
];
List<String> asia = [
  'china',
  'singafor',
  'indinisia',
  'india',
  'qatar',
  'japan',
  'south corea'
];
List<String> africa = [
  'south africa',
  'ghana',
  'zimbabwi',
  'mali',
  'nigeria',
  'algeria',
  'tunisia',
  'egybt'
];
List<String> namerica = ['usa', 'canada', 'mexic'];
List<String> nafrica = ['algeria', 'tunisia', 'egybt', 'lybia'];
List<String> australia = ['australia'];
