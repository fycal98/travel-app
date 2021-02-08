import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Screens/BookingScreen.dart';
import '../Screens/TripScreen.dart';
import 'package:http/http.dart' as http;

const selectedtext = TextStyle(color: Colors.white, fontSize: 15);

class CheckDateSheet extends StatefulWidget {
  CheckDateSheet({this.dates, this.title});
  List dates;
  String title;
  @override
  _CheckDateSheetState createState() => _CheckDateSheetState();
}

class _CheckDateSheetState extends State<CheckDateSheet> {
  int choosedDate = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fontfactor = size.height / 720;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35 * fontfactor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 5 * fontfactor,
                        width: 100 * fontfactor,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20 * fontfactor),
                            ),
                            Text(
                              'CHECK THE DATE',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12 * fontfactor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        child: CupertinoPicker(
                          onSelectedItemChanged: (i) {
                            choosedDate = i;
                          },
                          itemExtent: 50,
                          children: [
                            ...widget.dates
                                .map((e) => TripDate(
                                      data: e,
                                    ))
                                .toList()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onPressed: () async {
                            Navigator.of(context).pushNamed(
                              BookingScreen.route,
                            );
                          },
                          color: Colors.blue.shade500,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40 * fontfactor,
                                vertical: 15 * fontfactor),
                            child: Text(
                              'BOOK NOW',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class TripDate extends StatelessWidget {
  const TripDate({Key key, this.data}) : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.panorama_fish_eye,
            color: Colors.white,
            size: 12,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            data['date'].split('T')[0],
            style: selectedtext,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '${data['users'].length}/30',
            style: selectedtext,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            data['state'],
            style: selectedtext,
          ),
          IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                print('click');
              })
        ],
      ),
    );
  }
}
