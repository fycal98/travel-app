import 'package:flutter/material.dart';
import '../Widgets/Drawer.dart';

class SearchScreen extends StatefulWidget {
  static const route = 'SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    List trips = ModalRoute.of(context).settings.arguments;
    var size = MediaQuery.of(context).size;
    var factor = size.height / 720;
    return Scaffold(
      endDrawer: RightDrawer(),
      body: Stack(
        children: [
          ListView(
            children: trips
                .map((e) => TripCard(
                    imageUrl: e['imageUrl'],
                    price: e['price'],
                    starC: e['starC'],
                    title: e['title'],
                    description: e['description'],
                    endC: e['endC']))
                .toList(),
          )
        ],
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  const TripCard({
    this.title,
    this.price,
    this.imageUrl,
    this.endC,
    this.starC,
    this.description,
    Key key,
  }) : super(key: key);
  final imageUrl;
  final title;
  final price;
  final starC;
  final endC;
  final description;

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
                      fit: BoxFit.cover, image: NetworkImage(imageUrl)),
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
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                      'from  ',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      '\$$price',
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
                      description,
                      style: TextStyle(fontSize: 8),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                        'START CITY, $starC\n'
                        'END CITY, $endC',
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
