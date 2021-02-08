import 'dart:ui';

import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import 'TripStyle.dart';

class TripStyleScreen extends StatelessWidget {
  static const route = 'TripStyleScreen';
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
                            'TRIP STYLE',
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
                    text:
                        'Bright blue waters ,stuning beaches ande more hidden gems\n'
                        'our sailing trips are pretty much what dreams made of',
                    image: 'sailing.jpg',
                    title: 'SAILING',
                  ),
                  StyleGrid(
                    text:
                        'Bright blue waters ,stuning beaches ande more hidden gems\n'
                        'our sailing trips are pretty much what dreams made of',
                    image: 'camping.jpg',
                    title: 'CAMPING',
                  ),
                  StyleGrid(
                    text:
                        'Bright blue waters ,stuning beaches ande more hidden gems\n'
                        'our sailing trips are pretty much what dreams made of',
                    image: 'explorer.jpg',
                    title: 'EXPLORER',
                  ),
                  StyleGrid(
                    text:
                        'Bright blue waters ,stuning beaches ande more hidden gems\n'
                        'our sailing trips are pretty much what dreams made of',
                    image: 'hotel.jpg',
                    title: 'HOTEL',
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
  final String text;
  const StyleGrid({this.text, this.image, this.title});

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
                                  fontSize: 25 * factor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 7 * factor,
                                ))
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
                              Navigator.pushNamed(context, TripStyle.route,
                                  arguments: {
                                    'title': title,
                                    'text': text,
                                    'image': image
                                  });
                            },
                            child: Text(
                              'FIND YOUR TRIP',
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
