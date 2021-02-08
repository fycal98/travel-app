import 'dart:ui';

import 'package:flutter/material.dart';
import '../Screens/TripDestination.dart';

class CountriesSheet extends StatefulWidget {
  List<String> countries = [];
  String region;

  CountriesSheet({this.countries, this.region});
  @override
  _CountriesSheetState createState() => _CountriesSheetState();
}

class _CountriesSheetState extends State<CountriesSheet> {
  List<String> selectedcountries = [];
  Function editcountry(String c) {
    if (selectedcountries.contains(c)) {
      selectedcountries.remove(c);
    } else
      selectedcountries.add(c);
    setState(() {});
  }

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
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'EUROPE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20 * fontfactor),
                            ),
                            Text(
                              'SELECT COUNTRIES',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12 * fontfactor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        child: GridView.count(
                          childAspectRatio: 3,
                          crossAxisCount: 2,
                          children: widget.countries
                              .map((e) => Country(
                                    country: e,
                                    editcountry: editcountry,
                                    selectedcountries: selectedcountries,
                                  ))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onPressed: () {
                            Navigator.pushNamed(context, TripDestination.route,
                                arguments: {
                                  'selectedcountries': selectedcountries,
                                  'region': widget.region
                                });
                          },
                          color: Colors.blue.shade500,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40 * fontfactor,
                                vertical: 15 * fontfactor),
                            child: Text(
                              'COMPLETED',
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

class Country extends StatelessWidget {
  final String country;
  final Function editcountry;
  final List<String> selectedcountries;
  const Country({this.country, this.editcountry, this.selectedcountries});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fontfactor = size.height / 720;
    return TextButton.icon(
        style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            minimumSize: MaterialStateProperty.all(Size(0, 0))),
        onPressed: () {
          editcountry(country);
        },
        icon: Icon(
          selectedcountries.contains(country)
              ? Icons.circle
              : Icons.panorama_fish_eye,
          color: Colors.white,
          size: 12 * fontfactor,
        ),
        label: Text(
          country,
          style: TextStyle(color: Colors.white, fontSize: 12 * fontfactor),
        ));
  }
}
