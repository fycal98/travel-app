import 'package:flutter/material.dart';
import '../Widgets/TripSheet.dart';
import '../Widgets/CheckDateSheet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MYINH extends InheritedWidget {
  final Function changeheight;
  final size;
  final id;
  const MYINH(
      {Key key, @required Widget child, this.changeheight, this.size, this.id})
      : assert(child != null),
        super(key: key, child: child);

  static MYINH of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MYINH>();
  }

  @override
  bool updateShouldNotify(MYINH old) {
    return false;
  }
}

class TripScreen extends StatefulWidget {
  static const route = 'TripScreen';
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> with TickerProviderStateMixin {
  Map data;
  bool loadedData = false;
  double height = 300;
  Function changeheight(double h) {
    setState(() {
      height = h;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    http
        .get(
            'http://192.168.1.50:3000/trip/${ModalRoute.of(context).settings.arguments}?att=title,imageUrl,description,starC,endC,countries')
        .then((value) {
      data = jsonDecode(value.body)['trip'];
      setState(() {
        loadedData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MYINH(
      id: data == null ? null : data['_id'],
      changeheight: changeheight,
      size: size,
      child: Scaffold(
        body: !loadedData
            ? CircularProgressIndicator()
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(data['imageUrl']))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AnimatedSize(
                        duration: Duration(milliseconds: 200),
                        vsync: this,
                        curve: Curves.linear,
                        child: SizedBox(
                          height: height,
                        ),
                      ),
                      Text(
                        data['title'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                          'START CITY, ${data['starC']}\n'
                          'END CITY, ${data['endC']}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(data['description'],
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      Text(data['countries'].join(','),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70)),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      OutlinedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 18),
                              ),
                              side: MaterialStateProperty.all(
                                  BorderSide(width: 1, color: Colors.white)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))))),
                          onPressed: () async {
                            http.Response res = await http.get(
                                'http://192.168.1.50:3000/trip/${ModalRoute.of(context).settings.arguments}?att=dates');
                            showModalBottomSheet(
                                backgroundColor: Colors.white.withOpacity(0),
                                context: context,
                                builder: (context) => CheckDateSheet(
                                      dates: jsonDecode(res.body)['trip']
                                          ['dates'],
                                      title: data['title'],
                                    ));
                          },
                          child: Text(
                            'CHECK THE DATE',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Center(
                        child: Text(
                          'See more',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      SeeMore(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class SeeMore extends StatelessWidget {
  const SeeMore();

  @override
  Widget build(BuildContext context) {
    final Size size = MYINH.of(context).size;
    return Center(
      child: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: size.height * 0.05,
          ),
          onPressed: () async {
            final data = await http.get(
                'http://192.168.1.50:3000/trip/${MYINH.of(context).id}?att=reviews,itineraries');
            MYINH.of(context).changeheight(size.height * 0.2);
            showBottomSheet(
              context: context,
              builder: (context) => TripSheet(
                data: jsonDecode(data.body),
              ),
            ).closed.then(
                (value) => MYINH.of(context).changeheight(size.height * 0.35));
          }),
    );
  }
}
