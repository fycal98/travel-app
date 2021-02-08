import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Data.dart';
import 'package:provider/provider.dart';
import 'TripScreen.dart';

class TripStyle extends StatefulWidget {
  static const route = 'TripStyle';
  @override
  _TripStyleState createState() => _TripStyleState();
}

class _TripStyleState extends State<TripStyle> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return Scaffold(
      endDrawer: RightDrawer(),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white.withOpacity(0),
                flexibleSpace: Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              data['title'],
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35 * factor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Flexible(
                            child: Text(data['text'],
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10 * factor,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/${data['image']}'))),
                  height: 450,
                ),
                expandedHeight: 430,
              ),
              FutureBuilder<http.Response>(
                future: http.get(
                    'http://192.168.1.50:3000/trip?style=${data['title'].toLowerCase()}',
                    headers: {
                      'Authorization': context.read<Data>().userInfo[0]
                    }),
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? SliverList(delegate: SliverChildListDelegate([]))
                        : SliverList(
                            delegate: SliverChildListDelegate([
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, top: 10),
                                child: Text(
                                  'SORT BY PRICE',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black45),
                                ),
                              ),
                            ),
                            ...jsonDecode(snapshot.data.body)
                                .map((e) => TripCard(
                                      data: e,
                                    ))
                                .toList()
                          ])),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  const TripCard({Key key, this.data}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(TripScreen.route, arguments: data['_id']);
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
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
                        image: NetworkImage(data['imageUrl'])),
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
                    data['title'],
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        'from  ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        '\$${data['price']}',
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
                        data['description'],
                        style: TextStyle(fontSize: 8),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                          'START CITY, ${data['starC']}\n'
                          'END CITY, ${data['endC']}',
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.w500))
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
      ),
    );
  }
}
