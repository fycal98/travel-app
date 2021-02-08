import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  static const route = 'BookingScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        title: Center(
            child: Text(
          'BOOK NOW',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            card(
              title: ' STATUS OF YOUR TRIP',
              widget: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 15,
                          ),
                          Text('15 sept-4 oct'),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 15,
                          ),
                          Text(' confirmed'),
                        ],
                      ),
                    ],
                  )),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '\$2,780.10 ',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            card(
              title: ' FLIGHT',
              widget: Text('Dont need to book filght ticket.already booked'),
            ),
            card(
              title: ' ACOMONDATION',
              widget: Text('Dont need to upgrade hotels'),
            ),
            Activities(),
          ],
        ),
      ),
    );
  }
}

class Activities extends StatefulWidget {
  const Activities({
    Key key,
  }) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  List<int> selecteditems = [];
  Function selectitem(int i) {
    setState(() {
      if (selecteditems.contains(i))
        selecteditems.remove(i);
      else
        selecteditems.add(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: Colors.black87,
                size: 10,
              ),
              Text(
                ' ACTIVITIES',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '[5/15]',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Activity(
                  select: selectitem,
                  index: 1,
                  selected: selecteditems.contains(1),
                ),
                Activity(
                  select: selectitem,
                  index: 2,
                  selected: selecteditems.contains(2),
                ),
                Activity(
                  select: selectitem,
                  index: 3,
                  selected: selecteditems.contains(3),
                ),
                Activity(
                  select: selectitem,
                  index: 4,
                  selected: selecteditems.contains(4),
                ),
                Activity(
                  select: selectitem,
                  index: 5,
                  selected: selecteditems.contains(5),
                ),
                Activity(
                  select: selectitem,
                  index: 6,
                  selected: selecteditems.contains(6),
                ),
                Activity(
                  select: selectitem,
                  index: 7,
                  selected: selecteditems.contains(7),
                ),
              ],
            ),
          ),
        ),
        Text(
          'TOTAL PRICE',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '\$1750.00 + \$480.00',
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '\$2,780.10 ',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 70, top: 10, left: 70),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            onPressed: () {},
            color: Colors.blue.shade500,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Text(
                'CONFIRM',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Activity extends StatelessWidget {
  final bool selected;
  final int index;
  final Function select;

  const Activity({Key key, this.selected, this.index, this.select})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          select(index);
        },
        child: Container(
          width: 140,
          height: 75,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/c4/5e/c3/c45ec382a9bc11f03a4c7da92158dbf0.jpg')),
              color: Colors.greenAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(selected ? 0.5 : 0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'DAY 3',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Camping',
                      style: TextStyle(fontSize: 10, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            selected
                ? Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blueAccent,
                    ),
                  )
                : Center(),
          ]),
        ),
      ),
    );
  }
}

class card extends StatelessWidget {
  final String title;
  final Widget widget;
  const card({Key key, this.title, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.black87,
              size: 10,
            ),
            Text(
              ' STATUS OF YOUR TRIP',
              style: TextStyle(fontWeight: FontWeight.w900),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: widget,
          ),
        )
      ],
    );
  }
}
